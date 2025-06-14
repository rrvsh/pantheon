{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    QUICK=false
    NO_GENERATION_CHECK=false
    TEST_SHELL=false
    REMOTE_HOSTS=()
    REBUILDING_ALL=false
    # ANSI color codes
    GREEN='\033[0;32m'
    ORANGE='\033[0;33m'
    RED='\033[0;31m'
    NC='\033[0m'

    info() {
      timestamp=$(date "+%Y-%m-%d %H:%M:%S")
      echo -e "''${GREEN}''${timestamp} INFO: $1''${NC}"
    }

    warn() {
      timestamp=$(date "+%Y-%m-%d %H:%M:%S")
      echo -e "''${ORANGE}''${timestamp} WARN: $1''${NC}"
    }

    err() {
      timestamp=$(date "+%Y-%m-%d %H:%M:%S")
      echo -e "''${RED}''${timestamp} ERROR: $1''${NC}"
    }

    prompt() {
      local PROMPT="$1"
      shift
      read -p "$PROMPT? (y/n) [n]: " -n 1 -r REPLY
      echo
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then
          "$*"
      else
          info "$PROMPT aborted."
      fi
    }

    spawn_test_shell() {
      info "Spawning test shell on $1..."
      (export PS1="Test shell> "
      exec ${pkgs.bash}/bin/bash ssh "$1") || {
        ${pkgs.cowsay}/bin/cowsay "You aborted."
        exit 1
      }
    }

    rebuild_remote() {
      local args=(".#nixosConfigurations.$1" "--target-host" "$1")
      local CURRENT_GENERATION=$(ssh "$1" readlink /nix/var/nix/profiles/system | cut -d- -f2)

      if "$TEST_SHELL"; then
        info "Testing $1..."
        nh os test "''${args[@]}" || exit 1
        git diff HEAD --color=always --stat --patch
        spawn_test_shell "$1"
        info "Rebuilding $1..."
        nh os boot "''${args[@]}" || exit 1
      else
        info "Rebuilding $1 on $HOSTNAME..."
        nh os switch "''${args[@]}" || exit 1
      fi

      if ! "$NO_GENERATION_CHECK"; then
        local NEW_GENERATION=$(ssh "$1" readlink /nix/var/nix/profiles/system | cut -d- -f2)
        info "$1 - New generation is $NEW_GENERATION. Current is $CURRENT_GENERATION."
        if [ ! $NEW_GENERATION -gt $CURRENT_GENERATION ]; then
          warn "New config was not added to bootloader." 
        fi
      fi
    }

    info "Starting rebuild script."

    if [ ! -f "flake.nix" ]; then
      err "flake.nix not found in the current directory. Exiting."
      exit 1  # Indicate an error
    fi

    while [[ $# -gt 0 ]]; do
      case "$1" in
        --quick | -q)
          QUICK=true
          shift
          ;;
        --no-generation-check | -n)
          NO_GENERATION_CHECK=true
          shift
          ;;
        --test-shell | -t)
          TEST_SHELL=true
          shift
          ;;
        --all | -a)
          reachable_hosts=()
          hostnames=$(nix flake show --all-systems --json | , jq -r '.nixosConfigurations | keys | .[]')
          for host in ''${hostnames[@]}; do
            info "Checking if $host is reachable..."
            if ping -c 1 -W 1 "$host" > /dev/null 2>&1 ; then  
              info "$host is reachable."
              reachable_hosts+=("$host")
            else 
              warn "$host is unreachable."
            fi
          done
          REMOTE_HOSTS=(''${reachable_hosts[@]})
          REBUILDING_ALL=true
          shift
          ;;
        *)
          if [ !REBUILDING_ALL ]; then
            if ping -c 1 -W 1 "$1" > /dev/null 2>&1 ; then
              REMOTE_HOSTS+=("$1")
            else
              err "$1 is unreachable. Exiting."
              exit 1
            fi
          fi
          shift
          ;;
      esac
    done

    if [ ''${#REMOTE_HOSTS[@]} == 0 ]; then
      info "No hostnames provided."
      REMOTE_HOSTS=("$HOSTNAME")
    fi

    git add .

    for host in "''${REMOTE_HOSTS[@]}"; do
      rebuild_remote $host
    done

    if ! "$QUICK"; then
      prompt "Commit changes" commit
      prompt "Reboot system" sudo systemctl reboot
    fi

    info "Rebuild script completed successfully."
    exit 0
  ''

{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    QUICK=false
    NO_GENERATION_CHECK=false
    TEST_SHELL=false
    REMOTE_HOSTS=()
    REBUILDING_ALL=false

    prompt() {
      local PROMPT="$1"
      shift
      read -p "$PROMPT? (y/n) [n]: " -n 1 -r REPLY
      echo
      if [[ "$REPLY" =~ ^[Yy]$ ]]; then
          "$*"
      else
          echo "$PROMPT aborted."
      fi
    }

    spawn_test_shell() {
      echo "Spawning test shell on $1..."
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
        echo "Testing $1..."
        nh os test "''${args[@]}"
        git diff HEAD --color=always --stat --patch
        spawn_test_shell "$1"
        echo "Rebuilding $1..."
        nh os boot "''${args[@]}"
      else
        echo "Rebuilding $1 on $HOSTNAME..."
        nh os switch "''${args[@]}"
      fi

      if ! "$NO_GENERATION_CHECK"; then
        local NEW_GENERATION=$(ssh "$1" readlink /nix/var/nix/profiles/system | cut -d- -f2)
        echo "$1 - New generation is $NEW_GENERATION. Current is $CURRENT_GENERATION."
        if [ ! $NEW_GENERATION -gt $CURRENT_GENERATION ]; then
          echo "WARNING: New config was not added to bootloader." 
        fi
      fi
    }

    if [ ! -f "flake.nix" ]; then
      echo "Error: flake.nix not found in the current directory. Exiting."
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
            echo "Checking if $host is reachable..."
            if ping -c 1 -W 1 "$host" > /dev/null 2>&1 ; then  
              echo "$host is reachable."
              reachable_hosts+=("$host")
            else 
              echo "$host is unreachable."
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
              echo "$1 is unreachable. Exiting."
              exit 1
            fi
          fi
          shift
          ;;
      esac
    done

    if [ ''${#REMOTE_HOSTS[@]} == 0 ]; then
      echo "No hostnames provided."
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

    exit 0
  ''

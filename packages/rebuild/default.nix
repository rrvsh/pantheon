{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    if [ ! -f "flake.nix" ]; then
      echo "Error: flake.nix not found in the current directory. Exiting."
      exit 1  # Indicate an error
    fi

    #TODO: get hostnames from flake nixosConfigurations

    TEST_SHELL=false
    REMOTE_HOSTS=()
    ALL_HOSTS=("nemesis" "mellinoe" "apollo")
    REBUILDING_ALL=false

    CURRENT_GENERATION=$(readlink /nix/var/nix/profiles/system | cut -d- -f2)

    while [[ $# -gt 0 ]]; do
      case "$1" in
        --test-shell | -t)
          TEST_SHELL=true
          shift
          ;;
        --all | -a)
          reachable_hosts=()
          for host in ''${ALL_HOSTS[@]}; do
            if ping -c 1 -W 1 "$host" > /dev/null 2>&1 ; then  
              reachable_hosts+=("$host")
            fi
          done
          REMOTE_HOSTS=(''${reachable_hosts[@]})
          REBUILDING_ALL=true
          shift
          ;;
        *)
          if [ !REBUILDING_ALL ]; then
            REMOTE_HOSTS+=("$1")
          fi
          shift
          ;;
      esac
    done

    git add .

    if [ ''${#REMOTE_HOSTS[@]} -gt 0 ]; then
      for host in "''${REMOTE_HOSTS[@]}"; do
        echo "Rebuilding $host..."
        nixos-rebuild switch --flake .#"$host" --target-host "$host" --use-remote-sudo || {
          echo "Error: nixos-rebuild switch failed for $host. Check the output."
          exit 1
        }
      done
      exit 0
    fi

    if "$TEST_SHELL"; then
      nh os test . || {
        echo "Error: nixos-rebuild switch failed.  Check the output for details."
        exit 1
      }
      git diff HEAD --color=always --stat --patch
      (export PS1="Test shell> " 
      exec ${pkgs.bash}/bin/bash) || {
        ${pkgs.cowsay}/bin/cowsay "You aborted."
        exit 1
      }
      nh os boot . || {
        echo "Error: nixos-rebuild switch failed.  Check the output for details."
        exit 1
      }
    else
      git diff HEAD --color=always --stat --patch
      nh os switch . || {
        exit 1
      }
    fi

    NEW_GENERATION=$(readlink /nix/var/nix/profiles/system | cut -d- -f2)
    echo "New generation is $NEW_GENERATION. Current is $CURRENT_GENERATION."
    if [ ! $NEW_GENERATION -gt $CURRENT_GENERATION ]; then
      echo "ERROR: New config was not added to bootloader. Exiting..."
      exit 1
    else
      git commit

      read -p "Reboot the system now? (y/n) [n]: " -n 1 -r
      echo    # (optional) move to a new line
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Rebooting the system..."
        sudo systemctl reboot
      else
        echo "Not rebooting."
        exit 0
      fi
    fi
  ''

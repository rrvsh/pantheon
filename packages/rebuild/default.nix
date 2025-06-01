{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    TEST_SHELL=false
    REMOTE_HOSTS=()

    while [[ $# -gt 0 ]]; do
      case "$1" in
        --test-shell | -t)
          TEST_SHELL=true
          shift
          ;;
        *)
          REMOTE_HOSTS+="$1"
          shift
          ;;
      esac
    done

    if [ ! -f "flake.nix" ]; then
      echo "Error: flake.nix not found in the current directory. Exiting."
      exit 1  # Indicate an error
    fi

    git add .

    if [ ''${#REMOTE_HOSTS[@]} -gt 0 ]; then
      for host in "$REMOTE_HOSTS[@]"; do
        echo "Rebuilding $host..."
        nixos-rebuild switch --flake .#"$host" --target-host "$host" --use-remote-sudo || {
          echo "Error: nixos-rebuild switch failed for $host. Check the output."
          exit 1
        }
      done
      exit 0
    fi

    CURRENT_GENERATION=$(readlink /nix/var/nix/profiles/system | cut -d- -f2)

    nh os test . || {
      echo "Error: nixos-rebuild switch failed.  Check the output for details."
      exit 1
    }

    git diff HEAD --color=always --stat --patch

    if "$TEST_SHELL"; then
      (export PS1="Test shell> " 
      exec ${pkgs.bash}/bin/bash) || {
        ${pkgs.cowsay}/bin/cowsay "You aborted."
        exit 1
      }
    fi

    export NIXOS_LABEL="$(date +%d%m%y\ %H:%M:%S)"
    nh os boot . || {
      echo "Error: nixos-rebuild switch failed.  Check the output for details."
      exit 1
    }

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

{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    if [ ! -f "flake.nix" ]; then
      echo "Error: flake.nix not found in the current directory. Exiting."
      exit 1  # Indicate an error
    fi

    git add .

    if [ $# -gt 0 ]; then
      for arg in "$@"; do
        nixos-rebuild switch --flake .#"$arg" --target-host "$arg" --use-remote-sudo
      done
      exit 0
    fi

    CURRENT_GENERATION=$(readlink /nix/var/nix/profiles/system | cut -d- -f2)

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

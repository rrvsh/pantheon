{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    if [ ! -f "flake.nix" ]; then
      echo "Error: flake.nix not found in the current directory. Exiting."
      exit 1  # Indicate an error
    fi

    echo "--- building the new config... ---"
    git add .
    nh os test . || {
      echo "Error: nixos-rebuild switch failed.  Check the output for details."
      exit 1
    }

    echo "--- diffing... ---"
    git diff HEAD --color=always --stat --patch

    echo "--- opening test shell... ---"
    ${pkgs.cowsay}/bin/cowsay -f elephant "Entering a test shell.  Type 'exit 1' to abort changes and 'exit' to commit."
    PS1="Test shell> " $SHELL || {
      ${pkgs.cowsay}/bin/cowsay "You aborted."
      exit 1
    }

    echo "--- adding the built configuration to the bootloader... ---"
    nh os boot . || {
      echo "Error: nixos-rebuild switch failed.  Check the output for details."
      exit 1
    }
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
  ''

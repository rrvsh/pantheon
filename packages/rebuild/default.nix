{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    if [ ! -f "flake.nix" ]; then
      echo "Error: flake.nix not found in the current directory. Exiting."
      exit 1  # Indicate an error
    fi

    echo "--- building the new config... ---"
    git add .
    nixos-rebuild test --flake . --use-remote-sudo || {
      echo "Error: nixos-rebuild switch failed.  Check the output for details."
      exit 1
    }

    echo "--- diffing... ---"
    git diff HEAD --color=always --stat --patch

    echo "--- opening test shell... ---"
    ${pkgs.cowsay}/bin/cowsay -f elephant "Entering a test shell.  Type 'exit 1' to abort changes and 'exit' to commit."
    PS1="Test shell> " $SHELL || {
      ${pkgs.cowsay}/bin/cowsay -f satanic "You aborted."
      exit 1
    }

    echo "--- adding the built configuration to the bootloader... ---"
    nixos-rebuild switch --flake . --use-remote-sudo || {
      echo "Error: nixos-rebuild switch failed.  Check the output for details."
      exit 1
    }
    git commit
    exit 0
  ''

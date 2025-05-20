{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    if [ ! -f "flake.nix" ]; then
    echo "flake.nix not found in current directory. exiting..."
    exit 1
    fi

    git add . && \
    nixos-rebuild switch --flake . --use-remote-sudo && \
    ${pkgs.cowsay}/bin/cowsay -f elephant "Opening a test shell. Type exit 1 to abort and exit to commit your changes." && \
    $SHELL && \
    git commit -a
  ''

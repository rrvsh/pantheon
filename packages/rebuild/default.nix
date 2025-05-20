{ pkgs, ... }:
pkgs.writeShellScriptBin "rebuild" # sh
  ''
    if [ ! -f "flake.nix" ]; then
    echo "flake.nix not found in current directory. exiting..."
    exit 1
    fi

    git add . && \
    nixos-rebuild switch --flake . --use-remote-sudo && \
    echo "=== opening test shell. ===" && \
    echo "=== exit = commit       ===" && \
    echo "=== exit 1 = abort      ===" && \
    $SHELL && \
    git commit -a
  ''

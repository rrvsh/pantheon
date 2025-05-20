{ pkgs, ... }:
pkgs.writeShellScriptBin "inspect" # sh
  ''
    ${pkgs.tree}/bin/tree $(nix eval --raw nixpkgs#$*.outPath)
  ''

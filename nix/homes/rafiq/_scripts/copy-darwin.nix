{ pkgs, ... }:
pkgs.writeShellScriptBin "copy" # sh
  ''
    echo -n $@ | pbcopy
  ''

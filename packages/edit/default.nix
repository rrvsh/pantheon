{ pkgs, ... }:
let
  finder = "${pkgs.fzf}/bin/fzf --preview 'cat {}'";
in
pkgs.writeShellScriptBin "edit" # sh
  ''
    if [ $# -gt 0 ]; then
      $EDITOR $(${finder} -q $*)
    else
      $EDITOR $(${finder})
    fi
  ''

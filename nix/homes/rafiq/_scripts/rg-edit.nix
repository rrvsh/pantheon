{ pkgs, lib, ... }:
let
  inherit (lib.meta) getExe;
  rgFinder = "${getExe pkgs.ripgrep} --no-heading --line-number --color=always";
  fzfPreview = "${getExe pkgs.bat} --color=always --highlight-line {2} {1}";
  fzfCmd = "${getExe pkgs.fzf} --ansi --delimiter : --nth 1.. --preview '${fzfPreview}'";
in
pkgs.writeShellScriptBin "rg-edit" # sh
  ''
    if [ $# -gt 0 ]; then
      selected=$(${rgFinder} "$*" | ${fzfCmd})
    else
      selected=$(${rgFinder} "" | ${fzfCmd})
    fi

    if [ -n "$selected" ]; then
      file=$(echo "$selected" | cut -d: -f1)
      line=$(echo "$selected" | cut -d: -f2)
      $EDITOR +$line "$file"
    fi
  ''

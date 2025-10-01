{ pkgs, ... }:
pkgs.writeShellScriptBin "note" # bash
  ''
  offset="''${1:-0}"
  mkdir -p ~/notes/daily
  $EDITOR ~/notes/daily/$(date -v "$offset day" '+%Y%m%d').md
  ''

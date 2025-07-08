{ pkgs, ... }:
pkgs.writeShellScriptBin "note" # bash
  ''
    zk edit -i
    pushd ~/notebook > /dev/null
    git add .
    commit -u
    popd > /dev/null
  ''

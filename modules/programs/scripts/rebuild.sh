#!/bin/bash

rebuild_remote() {
  hostname=$1
  builder=localhost
  nixos-rebuild switch --flake .#"${hostname}" --target-host "$(whoami)"@"${hostname}" --build-host "${builder}" --use-remote-sudo
}

main() {
  if [[ $# -gt 1 ]]; then
    echo "Only one argument is allowed. Pass in a hostname or all."
    exit 1
  elif [[ $# -lt 1 ]]; then
    nh os switch .
    exit 0
  fi

  git add .

  case "$1" in
  nemesis)
    if [[ $HOSTNAME == "nemesis" ]]; then
      nh os switch .
    else
      rebuild_remote nemesis
    fi
    exit 0
    ;;
  all)
    nh os switch . &&
      rebuild_remote apollo
    exit 0
    ;;
  *)
    rebuild_remote "$1"
    exit 0
    ;;
  esac
}

main "$@"

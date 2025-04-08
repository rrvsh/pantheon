#!/bin/bash

rebuild_remote() {
  hostname=$1
  builder="nemesis"
  if [[ "${hostname}" == "${builder}" ]]; then
    nh os switch .
  else
    nixos-rebuild switch --flake .#"${hostname}" --target-host "$(whoami)"@"${hostname}" --build-host "${builder}" --use-remote-sudo
  fi
}

main() {
  if [[ $# -gt 1 ]]; then
    echo "Only one argument is allowed. Pass in a hostname or all."
    exit 1
  elif [[ $# -lt 1 ]]; then
    rebuild_remote "$HOSTNAME"
    exit 0
  fi

  git add .

  case "$1" in
  all)
    # Create a list of hostnames to rebuild
    hosts=("nemesis" "apollo")

    # Use parallel to rebuild each host
    , parallel rebuild ::: "${hosts[@]}"

    # Check the exit code of parallel
    if [[ $? -ne 0 ]]; then
      echo "One or more rebuilds failed."
      exit 1
    else
      exit 0
    fi
    ;;
  *)
    rebuild_remote "$1"
    exit 0
    ;;
  esac
}

main "$@"

{ pkgs, ... }:
pkgs.writeShellScriptBin "check" # bash
  ''
    check_nginx() {
      ssh apollo systemctl show nginx | grep '^ExecStart=' | grep -oP ' -c \K[^ ]+' | xargs cat
    }

    while [[ $# -gt 0 ]]; do
     case "$1" in
       nginx)
         check_nginx
         exit 0
       ;;
       *)
         echo "Unrecognised parameter."
         exit 1
       ;;
      esac
    done
  ''

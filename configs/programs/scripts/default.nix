{ pkgs, ... }:
{
  home-manager.users.rafiq = {
    home.packages = [
      (pkgs.writers.writePython3Bin "git-extract" {
        libraries = with pkgs.python3Packages; [
          magic
          chardet
        ];
      } (builtins.readFile ./git-extract.py))

      (pkgs.writeShellScriptBin "rebuild" # sh
        ''
          rebuild_remote() {
            git add .
            hostname=$1
            builder="nemesis"
            if [[ "''${hostname}" == "''${builder}" ]]; then
              nh os switch .
            else
              nixos-rebuild switch \
          --flake .#"''${hostname}" \
          --target-host "$(whoami)"@"''${hostname}" \
          --build-host "''${builder}" \
          --use-remote-sudo
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

            case "$1" in
            all)
              # Create a list of hostnames to rebuild
              hosts=("nemesis" "apollo" "mellinoe")

              # Use parallel to rebuild each host
              , parallel rebuild ::: "''${hosts[@]}"

              # Check the exit code of parallel
              if [[ $? -ne 0 ]]; then
                echo "One or more rebuilds failed."
                exit 1
              else
                exit 0
              fi
              ;;
            *)
              echo "=========================="
              echo "=== Rebuilding $1 ==="
              echo "=========================="
              rebuild_remote "$1"
              exit 0
              ;;
            esac
          }

          main "$@"
        ''
      )
      (pkgs.writeShellScriptBin "byebye" (builtins.readFile ./byebye.sh))
      (pkgs.writeShellScriptBin "deploy" (builtins.readFile ./deploy.sh))
    ];
  };
}

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

      (pkgs.writeShellScriptBin "rebuild" (builtins.readFile ./rebuild.sh))
      (pkgs.writeShellScriptBin "byebye" (builtins.readFile ./byebye.sh))
      (pkgs.writeShellScriptBin "deploy" (builtins.readFile ./deploy.sh))
    ];
  };
}

{ pkgs, ... }: {
  home.packages = [
    (pkgs.writers.writePython3Bin "git-extract" {

      libraries = with pkgs.python3Packages; [
        magic
        chardet
      ];

    } (builtins.readFile ./git-extract.py))

    (pkgs.writeShellScriptBin "rebuild" (builtins.readFile ./rebuild.sh))
  ];
}

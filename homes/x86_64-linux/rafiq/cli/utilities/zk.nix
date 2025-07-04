{ pkgs, ... }:
{
  persistDirs = [ "notebook" ];
  programs.zk = {
    enable = true;
    settings.notebook.dir = "~/notebook";
  };
  home.packages = [
    (pkgs.writeShellScriptBin "note" # bash
      ''
        zk edit -i
        pushd ~/notebook
        git add .
        commit
        popd
      ''
    )
  ];
}

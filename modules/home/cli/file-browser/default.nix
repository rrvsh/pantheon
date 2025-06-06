{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.file-browser == "yazi") {
    home.sessionVariables.FILE_BROWSER = "yazi";
    programs.yazi = {
      enable = true;
      shellWrapperName = "t";
      settings = {
        mgr = {
          sort_by = "natural";
        };
        opener = {
          play = [
            {
              run = "vlc \"$@\"";
              desc = "Open";
            }
          ];
        };
      };
    };
  };
}

{ config, lib, ... }:
{
  config = 
  lib.mkIf (config.cli.file-browser == "yazi") 
  {
    home.shellAliases.FILE-BROWSER = "yazi";
    programs.yazi = {
      enable = true;
      shellWrapperName = "t";
    };
  };
}

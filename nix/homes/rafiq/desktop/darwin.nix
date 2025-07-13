{ config, ... }:
let
  cfg = config.flake;
in
{
  flake.modules.darwin.graphical.homebrew = {
    enable = true;
    primaryUser = cfg.admin.username;
    onActivation.cleanup = "uninstall";
    casks = [ "ghostty" ];
  };
}

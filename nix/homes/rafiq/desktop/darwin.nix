{ config, ... }:
let
  cfg = config.flake;
in
{
  flake.modules.darwin.graphical.homebrew = {
    enable = true;
    user = cfg.admin.username;
    onActivation.cleanup = "uninstall";
    casks = [ "ghostty" ];
  };
}

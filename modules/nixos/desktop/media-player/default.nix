{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption optional singleton;
  inherit (pkgs) vlc;
  cfg = config.desktop.media-player;
in
{
  options.desktop.media-player = {
    vlc.enable = mkEnableOption "";
  };

  config.home-manager.sharedModules = optional cfg.vlc.enable { home.packages = singleton vlc; };
}

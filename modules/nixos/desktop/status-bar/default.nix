{ config, lib, ... }:
let
  inherit (lib) mkEnableOption singleton;
  cfg = config.desktop.status-bar;
in
{
  options.desktop.status-bar = {
    waybar.enable = mkEnableOption "";
  };

  config.home-manager.sharedModules = singleton { programs.waybar.enable = cfg.waybar.enable; };
}

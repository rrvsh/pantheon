{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.desktop.lockscreen;
in
{
  options.desktop.lockscreen = {
    hyprlock.enable = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf cfg.hyprlock.enable {
      security.pam.services.hyprlock = { };
    })
  ];
}

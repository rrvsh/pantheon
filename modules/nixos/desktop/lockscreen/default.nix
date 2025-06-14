{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    singleton
    ;
  cfg = config.desktop.lockscreen;
in
{
  options.desktop.lockscreen = {
    hyprlock.enable = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf cfg.hyprlock.enable {
      security.pam.services.hyprlock = { };
      home-manager.sharedModules = singleton { programs.hyprlock.enable = true; };
    })
  ];
}

{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    singleton
    optional
    ;
  inherit (lib.pantheon) mkStrOption;
  inherit (pkgs) font-awesome wl-clipboard-rs;
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = mkEnableOption "";
    enableWaylandUtilities = mkEnableOption "";
    mainMonitor = {
      id = mkStrOption;
      scale = mkStrOption;
      resolution = mkStrOption;
      refresh-rate = mkStrOption;
    };
  };

  config = mkIf cfg.enable {
    fonts.packages = singleton font-awesome;
    home-manager.sharedModules = optional cfg.enableWaylandUtilities {
      home.packages = [ wl-clipboard-rs ];
    };
  };
}

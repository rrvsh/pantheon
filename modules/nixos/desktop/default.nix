{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf singleton;
  inherit (lib.pantheon) mkStrOption;
  inherit (pkgs) wl-clipboard-rs;
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = mkEnableOption "";
    enableWaylandUtilities = mkEnableOption "";
    mainMonitor = {
      id = mkStrOption;
      scale = lib.pantheon.mkStrOption;
      resolution = lib.pantheon.mkStrOption;
      refresh-rate = lib.pantheon.mkStrOption;
    };
    enableSpotifyd = lib.mkEnableOption "";
    enableSteam = lib.mkEnableOption "";
    enableVR = lib.mkEnableOption "";
    enableSunshine = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    {
      fonts.packages = with pkgs; [
        font-awesome
      ];
    }
    (mkIf cfg.enableWaylandUtilities {
      home-manager.sharedModules = singleton { home.packages = [ wl-clipboard-rs ]; };
    })
    (lib.mkIf config.desktop.enableSteam {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    })
    (lib.mkIf config.desktop.enableVR {
      programs.alvr = {
        enable = true;
        openFirewall = true;
      };
      environment.systemPackages = [ pkgs.android-tools ];
    })
    (lib.mkIf config.desktop.enableSunshine {
      services.sunshine = {
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
        settings = {
          sunshine_name = config.system.hostname;
          origin_web_ui_allowed = "wan";
        };
        applications = { };
      };
    })
  ];
}

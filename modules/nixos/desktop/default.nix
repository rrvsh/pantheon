{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib.pantheon) mkStrOption;
in
{
  imports = [
    ./windowManager.nix
  ];

  options.desktop = {
    enable = mkEnableOption "";
    mainMonitor = {
      id = mkStrOption;
      scale = lib.pantheon.mkStrOption;
      resolution = lib.pantheon.mkStrOption;
      refresh-rate = lib.pantheon.mkStrOption;
    };
    windowManager = lib.pantheon.mkStrOption;
    terminal = lib.pantheon.mkStrOption;
    status-bar = lib.pantheon.mkStrOption;
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

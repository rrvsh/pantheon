{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./windowManager.nix
  ];

  options.desktop = {
    mainMonitor = {
      id = lib.pantheon.mkStrOption;
      scale = lib.pantheon.mkStrOption;
      resolution = lib.pantheon.mkStrOption;
      refresh-rate = lib.pantheon.mkStrOption;
    };
    windowManager = lib.pantheon.mkStrOption;
    lockscreen = lib.pantheon.mkStrOption;
    browser = lib.pantheon.mkStrOption;
    terminal = lib.pantheon.mkStrOption;
    notification-daemon = lib.pantheon.mkStrOption;
    enableSpotifyd = lib.mkEnableOption "";
    enableSteam = lib.mkEnableOption "";
    enableVR = lib.mkEnableOption "";
    enableSunshine = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
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
        };
        applications = { };
      };
    })
  ];
}

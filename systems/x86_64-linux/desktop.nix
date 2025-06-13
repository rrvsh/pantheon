{
  desktop = {
    enable = true;
    browser.firefox = {
      enable = true;
      syncedProfiles = [
        "rafiq"
        "test"
      ];
    };
    lockscreen.hyprlock.enable = true;
    windowManager = "hyprland";
    terminal = "ghostty";
    notification-daemon = "mako";
    launcher = "fuzzel";
    status-bar = "waybar";
    media-player = "vlc";
    mainMonitor = {
      id = "desc:OOO AN-270W04K";
      scale = "2";
      resolution = "3840x2160";
      refresh-rate = "60";
    };
    enableSpotifyd = true;
    enableSteam = true;
    enableVR = true;
    enableSunshine = true;
  };
}

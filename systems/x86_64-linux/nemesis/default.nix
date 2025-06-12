{
  lib,
  ...
}:
{
  imports = lib.singleton ../common.nix;

  system = {
    hostname = "nemesis";
    bootloader = "systemd-boot";
  };

  hardware = {
    drives.btrfs = {
      enable = true;
      drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
      ephemeralRoot = true;
    };
    platform = "amd";
    gpu = "nvidia";
  };

  desktop = {
    windowManager = "hyprland";
    browser = "firefox";
    terminal = "ghostty";
    lockscreen = "hyprlock";
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

  services = {
    tor = {
      enable = true;
      client.enable = true;
    };
  };
}

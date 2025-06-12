{ lib, ... }:
{

  system = {
    hostname = "mellinoe";
    bootloader = "systemd-boot";
  };

  hardware = {
    drives.btrfs = {
      enable = true;
      drive = "/dev/disk/by-id/nvme-KBG40ZPZ128G_TOSHIBA_MEMORY_Z0U103PCNCDL";
      ephemeralRoot = true;
    };
    platform = "intel";
  };

  desktop = {
    windowManager = "hyprland";
    browser = "firefox";
    terminal = "ghostty";
    lockscreen = "hyprlock";
    notification-daemon = "mako";
    launcher = "fuzzel";
    status-bar = "waybar";
    mainMonitor = {
      id = "BOE 0x088B";
      scale = "2";
      resolution = "1920x1280";
      refresh-rate = "60";
    };
  };
}

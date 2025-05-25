{
  lib,
  ...
}:
{
  system = {
    hostname = "nemesis";
    mainUser.name = "rafiq";
    mainUser.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
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
    mainMonitor = {
      id = "desc:OOO AN-270W04K";
      scale = "2";
      resolution = "3840x2160";
      refresh-rate = "60";
    };
    enableSpotifyd = true;
    enableSteam = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

{
  lib,
  ...
}:
{
  system.hostname = "nemesis";
  system.mainUser.name = "rafiq";
  system.mainUser.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
  system.bootloader = "systemd-boot";
  hardware.drives.btrfs = {
    enable = true;
    drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
    ephemeralRoot = true;
  };
  hardware.platform = "amd";
  hardware.gpu = "nvidia";

  desktop.windowManager = "hyprland";
  desktop.browser = "firefox";
  desktop.terminal = "ghostty";
  desktop.lockscreen = "hyprlock";
  desktop.notification-daemon = "mako";
  desktop.mainMonitor = {
    id = "desc:OOO AN-270W04K";
    scale = "2";
    resolution = "3840x2160";
    refresh-rate = "60";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

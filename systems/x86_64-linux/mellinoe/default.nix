{ lib, ... }:
{

  system = {
    hostname = "mellinoe";
    mainUser.name = "rafiq";
    mainUser.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
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
  };

  server = {
    mountHelios = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

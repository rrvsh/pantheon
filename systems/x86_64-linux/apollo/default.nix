{
  lib,
  ...
}:
{
  system = {
    hostname = "apollo";
    mainUser.name = "rafiq";
    mainUser.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n";
    bootloader = "systemd-boot";
  };
  hardware = {
    platform = "intel";
    drives.btrfs = {
      enable = true;
      drive = "";
      ephemeralRoot = true;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

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
      drive = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
      ephemeralRoot = true;
    };
  };

  server = {
    enableDDNS = true;
    mountHelios = true;
    databases.mongodb.enable = true;
    databases.mysql.enable = true;
    databases.postgresql.enable = true;
    web-apps.librechat.enable = true;
    web-servers.nginx.enable = true;
    web-servers.nginx.proxies = [
      {
        source = "aenyrathia.wiki";
        target = "http://helios:5896";
      }
      {
        source = "chat.bwfiq.com";
        target = "http://localhost:3080";
      }
      {
        source = "il.bwfiq.com";
        target = "http://helios:2283";
      }
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

{
  config,
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
    librechat = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      mongodbURI = "mongodb://apollo:27017";
      credentials = {
        creds_key_file = config.sops.secrets."librechat/creds_key".path;
        creds_iv_file = config.sops.secrets."librechat/creds_iv".path;
        jwt_secret_file = config.sops.secrets."librechat/jwt_secret".path;
        jwt_refresh_secret_file = config.sops.secrets."librechat/jwt_refresh_secret".path;
      };
    };
  };

  environment.persistence."/persist".directories = [
    {
      directory = config.server.librechat.path;
      user = config.server.librechat.user;
      group = config.server.librechat.group;
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

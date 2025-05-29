{ lib, config, ... }:
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
    launcher = "fuzzel";
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

  server = {
    mountHelios = true;
    reverse-proxy = {
      enable = true;
      type = "nginx";
      proxies = [
        {
          source = "chat.bwfiq.com";
          target = "";
        }
      ];
    };
    librechat = {
      enable = true;
      mongodbURI = "mongodb://apollo:27017";
      creds_key_file = config.sops.secrets."librechat/creds_key".path;
      creds_iv_file = config.sops.secrets."librechat/creds_iv".path;
      jwt_secret_file = config.sops.secrets."librechat/jwt_secret".path;
      jwt_refresh_secret_file = config.sops.secrets."librechat/jwt_refresh_secret".path;
      meili_master_key_file = config.sops.secrets."librechat/meili_master_key".path;
    };
  };

  environment.persistence."/persist".directories = [
    {
      directory = config.server.librechat.path;
      user = config.server.librechat.user;
      group = "librechat";
    }
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

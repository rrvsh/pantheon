{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    "${inputs.rrvsh-nixpkgs}/nixos/modules/services/web-apps/librechat.nix"
  ];

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
    status-bar = "waybar";
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
  };

  services.librechat = {
    enable = true;
    openFirewall = true;
    env = {
      HOST = "0.0.0.0";
      ALLOW_REGISTRATION = "true";
      MONGO_URI = "mongodb://apollo:27017";
    };
    credentials = {
      CREDS_KEY = config.sops.secrets."librechat/creds_key".path;
      CREDS_IV = config.sops.secrets."librechat/creds_iv".path;
      JWT_SECRET = config.sops.secrets."librechat/jwt_secret".path;
      JWT_REFRESH_SECRET = config.sops.secrets."librechat/jwt_refresh_secret".path;
    };
    settings = {
      version = "1.0.8";
      cache = true;
      interface = {
        privacyPolicy = {
          externalUrl = "https://librechat.ai/privacy-policy";
          openNewTab = true;
        };
      };
      endpoints = {
        custom = [
          {
            name = "OpenRouter";
            apiKey = "\${OPENROUTER_KEY}";
            baseURL = "https://openrouter.ai/api/v1";
            models = {
              default = [ "meta-llama/llama-3-70b-instruct" ];
              fetch = true;
            };
            titleConvo = true;
            titleModule = "meta-llama/llama-3-70b-instruct";
            dropParams = [ "stop" ];
            modelDisplayLabel = "OpenRouter";
          }
        ];
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

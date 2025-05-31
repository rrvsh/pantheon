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
      env = {
        TEST_ENV_VAR = "hello";
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

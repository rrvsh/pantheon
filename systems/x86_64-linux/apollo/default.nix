{
  lib,
  ...
}:
{
  imports = lib.singleton ../common.nix;

  system = {
    hostname = "apollo";
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
    monitoring = {
      prometheus = {
        enable = true;
      };
      grafana = {
        enable = true;
        url = "grafana.bwfiq.com";
      };
    };
    networking.ddns = {
      enable = true;
      domains = [
        "rrv.sh"
        "aenyrathia.wiki"
        "slayment.com"
      ];
    };
    databases = {
      mongodb.enable = true;
      mysql.enable = true;
      postgresql.enable = true;
    };
    web-apps = {
      librechat.enable = true;
      librechat.url = "chat.bwfiq.com";
      mattermost.enable = true;
      mattermost.url = "mm.bwfiq.com";
    };
    web-servers = {
      enableSSL = true;
      nginx = {
        enable = true;
        proxies = [
          {
            source = "aenyrathia.wiki";
            target = "http://helios:5896";
          }
          {
            source = "il.bwfiq.com";
            target = "http://helios:2283";
          }
        ];
      };
    };
  };
}

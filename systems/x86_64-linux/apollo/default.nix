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
    networking.ddns = {
      enable = true;
      domains = [
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
      librechat.domain = "chat.bwfiq.com";
      forgejo.enable = true;
      forgejo.domain = "git.rrv.sh";
      glance.enable = true;
      glance.domain = "glance.bwfiq.com";
      mattermost = {
        enable = true;
        domain = "mm.bwfiq.com";
        extraCfg.siteName = "pantheon";
      };
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

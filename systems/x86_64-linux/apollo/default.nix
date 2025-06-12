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
    enableDDNS = true;
    databases = {
      mongodb.enable = true;
      mysql.enable = true;
      postgresql.enable = true;
    };
    web-apps = {
      librechat.enable = true;
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
            #TODO: merge into librechat module
            source = "chat.bwfiq.com";
            target = "http://localhost:3080";
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

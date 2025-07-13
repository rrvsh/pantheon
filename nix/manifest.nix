{
  flake.manifest = {
    users.rafiq = {
      primary = true;
      name = "Mohammad Rafiq";
      email = "rafiq@rrv.sh";
      shell = "fish";
      pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n rafiq";
    };
    hosts.darwin.venus.graphical = true;
    hosts.nixos = {
      nemesis = {
        graphical = true;
        machine = {
          platform = "amd";
          gpu = "nvidia";
          root.drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
          monitors.main = {
            id = "desc:OOO AN-270W04K";
            resolution = "3840x2160";
            refresh-rate = "60";
            scale = "2";
          };
        };
        extraCfg = {
          services.fwupd.enable = true; # FIXME: remove
          machine = {
            bluetooth.enable = true;
            usb.automount = true;
            virtualisation = {
              podman.enable = true;
              podman.distrobox.enable = true;
            };
          };
          server.web-apps = {
            comfy-ui.enable = true;
            sd-webui-forge.enable = true;
          };
        };
      };
      apollo = {
        graphical = false;
        machine = {
          platform = "intel";
          root.drive = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
        };
        extraCfg.server = {
          ddns = {
            enable = true;
            domains = [
              "aenyrathia.wiki"
              "slayment.com"
            ];
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
          databases = {
            mongodb.enable = true;
            mysql.enable = true;
            postgresql.enable = true;
          };
          web-apps = {
            librechat = {
              enable = true;
              domain = "chat.bwfiq.com";
            };
            forgejo = {
              enable = true;
              domain = "git.rrv.sh";
              openFirewall = true;
            };
            rrv-sh.enable = true;
            rrv-sh.domain = "rrv.sh";
          };
        };
      };
    };
  };
}

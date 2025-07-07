let
  testCfg =
    { hostName, ... }:
    {
      boot.loader.systemd-boot.enable = true;
      networking = { inherit hostName; };
    };
in
{
  flake.manifest = {
    users.rafiq = {
      primary = true;
      name = "Mohammad Rafiq";
      email = "rafiq@rrv.sh";
      shell = "fish";
      pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n rafiq";
    };
    hosts.nixos = {
      nemesis = {
        machine = {
          platform = "amd";
          gpu = "nvidia";
          root.drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
          monitors = [
            {
              id = "desc:OOO AN-270W04K";
              scale = "2";
              resolution = "3840x2160";
              refresh-rate = "60";
            }
          ];
        };
        extraCfg = testCfg;
      };
      apollo = {
        machine = {
          platform = "intel";
          root.drive = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
        };
        extraCfg = testCfg;
      };
    };
  };
}

{ config, inputs, ... }:
{
  flake.modules.nixos.default =
    { hostName, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];
      boot.initrd.kernelModules = [ "dm-snapshot" ];
      # BTRFS - may add more later on
      disko.devices.disk.main = {
        device = config.flake.manifest.hosts.nixos.${hostName}.machine.root.drive;
        type = "disk";
        content.type = "gpt";
        content.partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };
      };

      disko.devices.lvm_vg.root_vg = {
        type = "lvm_vg";
        lvs.root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/root".mountpoint = "/";
              "/persist" = {
                mountpoint = "/persist";
                mountOptions = [
                  "subvol=persist"
                  "noatime"
                ];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "subvol=nix"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
}

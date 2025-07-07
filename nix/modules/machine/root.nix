{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib.modules) mkMerge mkIf mkAfter;
in
{
  flake.modules.nixos.default =
    { hostName, ... }:
    let
      inherit (config.flake.manifest.hosts.nixos.${hostName}.machine) root;
    in
    {
      imports = [ inputs.disko.nixosModules.disko ];
      config = mkMerge [
        {
          # BTRFS - may add more later on
          boot.initrd.kernelModules = [ "dm-snapshot" ];
          disko.devices.disk.main = {
            device = root.drive;
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
        }
        # Ephemeral by default - assumes btrfs
        (mkIf (config.flake.manifest.hosts.nixos.${hostName}.machine.root.ephemeral or true) {
          boot.initrd.postDeviceCommands = mkAfter ''
            mkdir /btrfs_tmp
            mount /dev/root_vg/root /btrfs_tmp

            if [[ -e /btrfs_tmp/root ]]; then
              btrfs subvolume delete "/btrfs_tmp/root"
            fi
          '';
        })
      ];
    };
}

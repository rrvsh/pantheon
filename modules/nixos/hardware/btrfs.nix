{ lib, config, ... }:
let
  cfg = config.hardware.drives.btrfs;
in
{
  config = lib.mkIf (cfg.enable) (
    lib.mkMerge [
      {
        boot.initrd.kernelModules = [ "dm-snapshot" ];
        disko.devices.disk.main = {
          device = cfg.drive;
          type = "disk";
          content.type = "gpt";
          content.partitions = {
            boot.name = "boot";
            boot.size = "1M";
            boot.type = "EF02";
            esp.name = "ESP";
            esp.size = "500M";
            esp.type = "EF00";
            esp.content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
            swap.size = "4G";
            swap.content = {
              type = "swap";
              resumeDevice = true;
            };
            root.name = "root";
            root.size = "100%";
            root.content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };

        disko.devices.lvm_vg.root_vg = {
          type = "lvm_vg";
          lvs.root.size = "100%FREE";
          lvs.root.content.type = "btrfs";
          lvs.root.content.extraArgs = [ "-f" ];
          lvs.root.content.subvolumes = {
            "/root".mountpoint = "/";
            "/persist".mountpoint = "/persist";
            "/persist".mountOptions = [
              "subvol=persist"
              "noatime"
            ];
            "/nix".mountpoint = "/nix";
            "/nix".mountOptions = [
              "subvol=nix"
              "noatime"
            ];
          };
        };
      }
      (lib.mkIf (cfg.ephemeralRoot) {
        boot.initrd.postDeviceCommands = lib.mkAfter ''
          	    mkdir /btrfs_tmp
          	    mount /dev/root_vg/root /btrfs_tmp
          	    if [[ -e /btrfs_tmp/root ]]; then
          		mkdir -p /btrfs_tmp/old_roots
          		timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          		mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          	    fi

          	    delete_subvolume_recursively() {
          		IFS=$'\n'
          		for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          		    delete_subvolume_recursively "/btrfs_tmp/$i"
          		done
          		btrfs subvolume delete "$1"
          	    }

          	    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          		delete_subvolume_recursively "$i"
          	    done

          	    btrfs subvolume create /btrfs_tmp/root
          	    umount /btrfs_tmp
          	  '';
        programs.fuse.userAllowOther = true;
        fileSystems."/persist".neededForBoot = true;
        environment.persistence."/persist" = {
          hideMounts = true;
          directories = [
            "/var/lib/systemd"
            "/var/lib/nixos"
          ];
          files = [
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
            "/etc/ssh/ssh_host_rsa_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
            "/etc/machine-id"
          ];
        };
      })
    ]
  );
}

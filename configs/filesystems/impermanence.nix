{
  inputs,
  lib,
  device ? throw "Set this to your disk device",
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
  ];
  # Disk Partitioning
  disko.devices.disk.main = {
    # device = "/dev/disk/by-id/nvme-eui.01000000000000008ce38e04019a68ab";
    inherit device;
    type = "disk";
    content.type = "gpt";
    content.partitions = {
      boot = {
        name = "boot";
        type = "EF02";
        size = "1M";
        priority = 1;
      };
      esp = {
        name = "ESP";
        type = "EF00";
        size = "500M";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [ "umask=0077" ];
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

  # Logical Volume Set up
  disko.devices.lvm_vg.root_vg = {
    type = "lvm_vg";
    lvs.root = {
      size = "100%FREE";
      content = {
        type = "btrfs";
        extraArgs = [ "-f" ];
        subvolumes = {
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
    };
  };

  # Back up old roots and delete older ones
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    		mkdir /btrfs_tmp
    		mount /dev/root_vg/root /btrfs_tmp
    		if [[ -e /btrfs_tmp/root ]]; then
    			mkdir -p /btrfs_tmp/old_roots
    			timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%M-%D_%H:%M:%S")
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

  # Directories to persist between boots
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    # Hide the mounts from showing up in the file manager.
    hideMounts = true;
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/machine-id"
    ];
    users.rafiq = {
      directories = [
        "repos"
      ];
      files = [
        ".config/sops/age/keys.txt"
        ".ssh/id_ed25519"
      ];
    };
  };
}

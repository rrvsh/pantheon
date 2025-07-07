{ config, lib, ... }:
let
  inherit (lib) mkMerge mkIf mkAfter;
in
{
  flake.modules.nixos.default =
    { hostName, ... }:
    {
      config = mkMerge [
        # Ephemeral by default - assumes btrfs
        (mkIf (config.flake.manifest.hosts.nixos.${hostName}.machine.root.ephemeral or true) {
          boot.initrd.postDeviceCommands = mkAfter ''
            mkdir /btrfs_tmp
            mount /dev/root_vg/root /btrfs_tmp

            if [[ -e /btrfs_tmp/root ]]; then
              btrfs subvolume delete "/btrfs_tmp/root"
            fi
          '';
          persistFiles = [
            #TODO: move to system config
            "/etc/machine-id"
            #TODO: move to ssh config
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
            "/etc/ssh/ssh_host_rsa_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
          ];
          persistDirs = [
            "/var/lib/systemd"
            "/var/lib/nixos"
          ];
        })
      ];
    };
}

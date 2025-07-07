{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkMerge mkIf mkAfter;
in
{
  flake.modules.nixos.default =
    { hostName, ... }:
    let
      inherit (config.flake.manifest.hosts.nixos.${hostName}.machine) root;
    in
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];
      config = mkMerge [
        # Ephemeral by default - assumes btrfs
        (mkIf (root.ephemeral or true) {
          boot.initrd.postDeviceCommands = mkAfter ''
            mkdir /btrfs_tmp
            mount /dev/root_vg/root /btrfs_tmp

            if [[ -e /btrfs_tmp/root ]]; then
              btrfs subvolume delete "/btrfs_tmp/root"
            fi
          '';
          programs.fuse.userAllowOther = true;
          fileSystems."/persist".neededForBoot = true;
          environment.persistence."/persist" = {
            hideMounts = true;
            files = [
              "/etc/ssh/ssh_host_ed25519_key"
              "/etc/ssh/ssh_host_ed25519_key.pub"
              "/etc/ssh/ssh_host_rsa_key"
              "/etc/ssh/ssh_host_rsa_key.pub"
              "/etc/machine-id"
            ];
          };
        })
      ];
    };
}

{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (lib.modules) mkMerge;
  inherit (cfg.lib.modules) forAllUsers';
in
{
  flake.modules.nixos.default = mkMerge [
    {
      persistFiles = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
      users.users = forAllUsers' (_: value: { openssh.authorizedKeys.keys = [ value.pubkey ]; });
    }
    { users.users.root.openssh.authorizedKeys.keys = [ cfg.admin.pubkey ]; }
  ];
}

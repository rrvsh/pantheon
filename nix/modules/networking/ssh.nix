{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (config.manifest) admin;
  inherit (lib.modules) mkMerge;
  inherit (cfg.lib.modules) forAllUsers';
in
{
  flake.modules.nixos.default = mkMerge [
    {
      services.openssh.enable = true;
      users.users = forAllUsers' (_: value: { openssh.authorizedKeys.keys = [ value.pubkey ]; });
      persistFiles = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    }
    { users.users.root.openssh.authorizedKeys.keys = [ admin.pubkey ]; }
  ];
  flake.modules.homeManager.default = {
    persistDirs = [ ".ssh" ];
    programs.ssh.enable = true;
    programs.ssh.extraConfig = ''
      Host *
        SetEnv TERM=xterm-256color
    '';
  };
}

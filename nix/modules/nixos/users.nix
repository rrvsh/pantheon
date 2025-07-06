{ config, ... }:
let
  inherit (config.flake.manifest) owner;
in
{
  flake.modules.nixos.default =
    { pkgs, ... }:
    {
      #TODO: move sudo/security options elsewhere
      security.sudo.wheelNeedsPassword = false;
      nix.settings.trusted-users = [ "@wheel" ];
      #TODO: move to shell config
      programs.${owner.shell}.enable = true;
      #TODO: move ssh key settings elsewhere
      users = {
        mutableUsers = false;
        groups.users.gid = 100;
        users.root.openssh.authorizedKeys.keys = [ owner.pubkey ];
        users.${owner.username} = {
          isNormalUser = true;
          # hashedPasswordFile
          extraGroups = [ "wheel" ];
          shell = pkgs.${owner.shell};
          openssh.authorizedKeys.keys = [ owner.pubkey ];
        };
      };
    };
}

{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (config.flake.lib) forAllUsers flattenAttrs;
  inherit (lib.attrsets) filterAttrs;
  owner = flattenAttrs (filterAttrs (_: v: (v.primary or false)) cfg.manifest.users);
in
{
  flake.modules.nixos.default =
    { pkgs, config, ... }:
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
      home-manager.users = forAllUsers (
        name: _: {
          #TODO: move into nixos/darwin config - should not apply to homeConfigurations
          home.username = name;
          home.homeDirectory = config.users.users.${name}.home;
        }
      );
    };
}

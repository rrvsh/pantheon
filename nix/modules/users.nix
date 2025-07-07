{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (cfg.lib) forAllUsers';
  inherit (lib.lists) optional;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    {
      #TODO: move sudo/security options elsewhere
      # security.sudo.wheelNeedsPassword = false;
      # nix.settings.trusted-users = [ "@wheel" ];
      #TODO: move ssh key settings elsewhere
      # users.users.root.openssh.authorizedKeys.keys = [ owner.pubkey ];
      users = {
        mutableUsers = false;
        groups.users.gid = 100;
        users = forAllUsers' (
          _: value: {
            isNormalUser = true;
            extraGroups = optional (value.primary or false) "wheel";
            openssh.authorizedKeys.keys = [ value.pubkey ];
          }
        );
      };
      home-manager.users = forAllUsers' (
        name: _: {
          home.username = name;
          home.homeDirectory = config.users.users.${name}.home;
        }
      );
    };
}

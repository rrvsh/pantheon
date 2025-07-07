{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (cfg.lib.modules) userListToAttrs forAllUsers';
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
      # persist uids and gids
      persistDirs = [ "/var/lib/nixos" ];
      users = {
        mutableUsers = false;
        groups.users.gid = 100;
        users = forAllUsers' (
          name: value: {
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets."${name}/hashedPassword".path;
            extraGroups = optional (value.primary or false) "wheel";
            openssh.authorizedKeys.keys = [ value.pubkey ];
          }
        );
      };
      sops.secrets = userListToAttrs (name: {
        "${name}/hashedPassword" = {
          neededForUsers = true;
          sopsFile = cfg.paths.secrets + "/users.yaml";
        };
      });
      home-manager.users = forAllUsers' (
        name: _: {
          home.username = name;
          home.homeDirectory = config.users.users.${name}.home;
        }
      );
    };
}

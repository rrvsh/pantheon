{ config, ... }:
let
  cfg = config.flake;
  inherit (cfg.lib.modules) userListToAttrs forAllUsers';
in
{
  flake.modules.nixos.default =
    { config, ... }:
    {
      persistDirs = [ "/var/lib/nixos" ];
      users = {
        mutableUsers = false;
        groups.users.gid = 100;
        users = forAllUsers' (
          name: _: {
            isNormalUser = true;
            hashedPasswordFile = config.sops.secrets."${name}/hashedPassword".path;
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
  flake.modules.darwin.default =
    { config, ... }:
    {
      home-manager.users = forAllUsers' (
        name: _: {
          home.username = name;
          home.homeDirectory = config.users.users.${name}.home;
        }
      );
    };
}

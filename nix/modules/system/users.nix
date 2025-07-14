{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (cfg.lib.modules) userListToAttrs forAllUsers';
  inherit (lib.lists) findFirstIndex;
  inherit (builtins) attrNames;
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
      system.primaryUser = cfg.admin.username;
      users.knownUsers = attrNames cfg.manifest.users;
      users.users = forAllUsers' (
        name: _: {
          home = "/Users/${name}";
          uid = 501 + (findFirstIndex (x: x == name) null (attrNames cfg.manifest.users));
        }
      );
      home-manager.users = forAllUsers' (
        name: _: {
          home.username = name;
          home.homeDirectory = config.users.users.${name}.home;
        }
      );
    };
}

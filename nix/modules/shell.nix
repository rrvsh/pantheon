{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (cfg.lib) forAllUsers';
  inherit (lib.attrsets) mapAttrs';
in
{
  flake.modules.nixos.default =
    { pkgs, ... }:
    {
      programs = mapAttrs' (name: value: {
        name = value.shell;
        value.enable = true;
      }) cfg.manifest.users;
      users.users = forAllUsers' (_: value: { shell = pkgs.${value.shell}; });
    };
}

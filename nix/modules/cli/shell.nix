{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (cfg.lib.modules) forAllUsers';
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
  flake.modules.homeManager.default =
    { config, ... }:
    {
      programs.${cfg.manifest.users.${config.home.username}.shell}.enable = true;
    };
}

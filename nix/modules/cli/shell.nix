{ config, lib, ... }:
let
  cfg = config.flake;
  inherit (config.manifest) users;
  inherit (cfg.lib.modules) forAllUsers';
  inherit (lib.attrsets) mapAttrs';
in
{
  flake.modules = {
    nixos.default =
      { pkgs, ... }:
      {
        programs = mapAttrs' (name: value: {
          name = value.shell;
          value.enable = true;
        }) users;
        users.users = forAllUsers' (_: value: { shell = pkgs.${value.shell}; });
      };
    darwin.default =
      { pkgs, ... }:
      {
        programs = mapAttrs' (name: value: {
          name = value.shell;
          value.enable = true;
        }) users;
        users.users = forAllUsers' (_: value: { shell = pkgs.${value.shell}; });
        environment.shells = [ pkgs.fish ];
      };
    homeManager.default =
      { config, ... }:
      {
        programs.${users.${config.home.username}.shell}.enable = true;
        home.shell.enableShellIntegration = true;
      };
  };
}

{ inputs, config, ... }:
let
  inherit (cfg.lib) forAllUsers' flattenAttrs;
  cfg = config.flake;
  hm = inputs.home-manager;
  globalCfg = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      (flattenAttrs (cfg.modules.homeManager or { }))
    ];
    users = forAllUsers' (name: _: cfg.homes.${name});
  };
in
{
  imports = [ hm.flakeModules.home-manager ];
  flake.modules.nixos.default.imports = [ hm.nixosModules.home-manager ];
  flake.modules.nixos.default.config.home-manager = globalCfg;
}

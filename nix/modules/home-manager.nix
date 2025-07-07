{ inputs, config, ... }:
let
  inherit (cfg.lib.modules) forAllUsers';
  cfg = config.flake;
  hm = inputs.home-manager;
  globalCfg = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit (cfg) manifest; };
    sharedModules = [ cfg.modules.homeManager.default ];
    users = forAllUsers' (name: _: cfg.homes.${name});
  };
in
{
  imports = [ hm.flakeModules.home-manager ];
  flake.modules.nixos.default.imports = [ hm.nixosModules.home-manager ];
  flake.modules.nixos.default.config.home-manager = globalCfg;
}

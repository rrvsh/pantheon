{ inputs, ... }:
let
  hm = inputs.home-manager;
  globalCfg = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
in
{
  imports = [ hm.flakeModules.home-manager ];
  flake.modules.nixos.default.imports = [ hm.nixosModules.home-manager ];
  flake.modules.nixos.default.config = globalCfg;
}

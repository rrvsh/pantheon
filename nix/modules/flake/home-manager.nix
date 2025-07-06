{ inputs, ... }:
let
  hm = inputs.home-manager;
  globalCfg = {
    imports = [ hm.nixosModules.home-manager ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
in
{
  imports = [ hm.flakeModules.home-manager ];
  flake.modules.nixos.common = globalCfg;
}

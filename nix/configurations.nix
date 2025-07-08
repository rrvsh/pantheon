{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) nixosSystem;
  inherit (lib.lists) optional;
  inherit (lib.attrsets) mapAttrs;
  inherit (cfg.lib.modules) forAllUsers';
  cfg = config.flake;
  globalCfg = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ cfg.modules.homeManager.default ];
    users = forAllUsers' (name: _: cfg.modules.homeManager.${name});
  };
  hosts = cfg.manifest.hosts or { };
  mkConfigurations =
    class: hosts:
    mapAttrs (
      name: value:
      if class == "nixos" then
        nixosSystem {
          specialArgs.hostName = name;
          modules = [
            cfg.modules.nixos.default
            inputs.home-manager.nixosModules.home-manager
            { home-manager = globalCfg; }
            (value.extraCfg or { })
          ] ++ optional value.graphical cfg.modules.nixos.graphical;
        }
      else
        { }
    ) hosts;
in
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];
  flake.nixosConfigurations = mkConfigurations "nixos" hosts.nixos;
}

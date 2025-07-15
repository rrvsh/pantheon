{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (lib.lists) optional;
  inherit (lib.attrsets) mapAttrs;
  inherit (cfg.lib.modules) forAllUsers';
  inherit (config.manifest) hosts;
  cfg = config.flake;
  globalCfg = hostName: hostConfig: {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit hostName hostConfig; };
    sharedModules = [ cfg.modules.homeManager.default ];
    users = forAllUsers' (name: _: cfg.modules.homeManager.${name});
  };
  mkConfigurations =
    class: hosts:
    mapAttrs (
      name: value:
      if class == "nixos" then
        nixosSystem {
          specialArgs = {
            inherit (config.flake) self;
            hostName = name;
            hostConfig = value;
          };
          modules = [
            cfg.modules.nixos.default
            inputs.home-manager.nixosModules.home-manager
            { home-manager = globalCfg name value; }
            (value.extraCfg or { })
          ] ++ optional value.graphical cfg.modules.nixos.graphical;
        }
      else if class == "darwin" then
        darwinSystem {
          specialArgs = {
            inherit (config.flake) self;
            hostName = name;
            hostConfig = value;
          };
          modules = [
            cfg.modules.darwin.default
            inputs.home-manager.darwinModules.home-manager
            { home-manager = globalCfg name value; }
            (value.extraCfg or { })
          ] ++ optional value.graphical cfg.modules.darwin.graphical;
        }
      else
        { }
    ) hosts;
in
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];
  flake.nixosConfigurations = mkConfigurations "nixos" hosts.nixos;
  flake.darwinConfigurations = mkConfigurations "darwin" hosts.darwin;
}

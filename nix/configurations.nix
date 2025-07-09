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
  cfg = config.flake;
  globalCfg = name: hostConfig: {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit hostConfig;
      hostName = name;
    };
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
            { home-manager = globalCfg name value; }
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
  flake.darwinConfigurations.venus = darwinSystem {
    specialArgs = { inherit (config.flake) self; };
    modules = [
      (
        { pkgs, self, ... }:
        {
          environment.systemPackages = [ pkgs.vim ];
          services.tailscale.enable = true;
          nix.settings.experimental-features = "nix-command flakes";
          nix.enable = false;
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 6;
          nixpkgs.hostPlatform = "x86_64-darwin";
        }
      )
    ];
  };
}

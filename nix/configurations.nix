{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) nixosSystem;
  inherit (cfg.lib) flattenAttrs;
  inherit (lib.attrsets) mapAttrs;
  cfg = config.flake;
  hosts = cfg.manifest.hosts or { };
  mkConfigurations =
    class: hosts:
    mapAttrs (
      _: value:
      if class == "nixos" then
        nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            (flattenAttrs cfg.modules.nixos)
            (value.extraCfg or { })
          ];
        }
      else
        { }
    ) hosts;
in
{
  flake.nixosConfigurations = mkConfigurations "nixos" hosts.nixos;
}

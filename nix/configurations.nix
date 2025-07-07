{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) nixosSystem;
  inherit (lib.attrsets) mapAttrs;
  cfg = config.flake;
  hosts = cfg.manifest.hosts or { };
  mkConfigurations =
    class: hosts:
    mapAttrs (
      name: value:
      if class == "nixos" then
        nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit (cfg) manifest;
            hostName = name;
          };
          modules = [
            cfg.modules.nixos.default
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

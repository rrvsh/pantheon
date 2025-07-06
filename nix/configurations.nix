{ config, ... }:
let
  inherit (cfg.lib) extractConfigurations;
  cfg = config.flake;
  hosts = cfg.manifest.hosts or { };
in
{
  flake.nixosConfigurations = extractConfigurations "nixos/" hosts;
}

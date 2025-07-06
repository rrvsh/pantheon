{ config, ... }:
let
  inherit (cfg.lib) extractConfigurations;
  cfg = config.flake;
  hosts = cfg.hostSpec.hosts or { };
in
{
  flake.nixosConfigurations = extractConfigurations "nixos/" hosts;
}

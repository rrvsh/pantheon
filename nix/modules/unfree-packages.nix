{ lib, config, ... }:
let
  inherit (builtins) elem;
  inherit (lib) mkOption getName;
  inherit (lib.types) listOf str;
  predicate = pkg: elem (getName pkg) config.allowedUnfreePackages;
in
{
  options.allowedUnfreePackages = mkOption {
    type = listOf str;
    default = [ ];
  };
  config.flake.modules.nixos.default = {
    nixpkgs.config.allowUnfreePredicate = predicate;
  };
}

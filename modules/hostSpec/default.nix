{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (builtins) mapAttrs;
  inherit (lib) mkOption;
  inherit (lib.types) lazyAttrsOf submodule;
  cfg = config.hostSpec;
  hostOptions = submodule { };
  mkSystem =
    hostName: _hostConfig:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ { networking = { inherit hostName; }; } ];
    };
in
{
  options.hostSpec.hosts = mkOption {
    type = lazyAttrsOf hostOptions;
    default = { };
  };

  config = {
    flake.nixosConfigurations = mapAttrs mkSystem cfg.hosts;
  };
}

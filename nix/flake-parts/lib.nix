{ lib, inputs, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) lazyAttrsOf raw;
  inherit (inputs.flake-parts.lib) mkSubmoduleOptions;
in
{
  options.flake = mkSubmoduleOptions {
    lib = mkOption {
      type = lazyAttrsOf raw;
      default = { };
    };
  };
}

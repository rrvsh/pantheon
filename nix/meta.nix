{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) path lazyAttrsOf raw;
  inherit (inputs.flake-parts.lib) mkSubmoduleOptions;
  cfg = config.flake;
in
{
  options.flake = mkSubmoduleOptions {
    self = mkOption { type = raw; };
    lib = mkOption {
      type = lazyAttrsOf raw;
      default = { };
    };
    paths = {
      root = mkOption { type = path; };
      secrets = mkOption {
        type = path;
        readOnly = true;
      };
    };
  };
  config.flake = {
    paths.secrets = cfg.paths.root + "/secrets";
  };
}

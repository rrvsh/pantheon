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
  inherit (cfg.lib.attrsets) firstAttrNameMatching;
  cfg = config.flake;
  username = firstAttrNameMatching (_: v: v.primary or false) cfg.manifest.users;
in
{
  options.flake = mkSubmoduleOptions {
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
    admin = mkOption {
      type = lazyAttrsOf raw;
      default = { };
    };
  };
  config.flake = {
    paths.secrets = cfg.paths.root + "/secrets";
    admin = cfg.manifest.users.${username} // {
      inherit username;
    };
  };
}

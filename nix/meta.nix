{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (cfg.lib.options) mkStrOption;
  inherit (lib.types)
    path
    lazyAttrsOf
    raw
    deferredModule
    submodule
    ;
  inherit (inputs.flake-parts.lib) mkSubmoduleOptions;
  inherit (cfg.lib.attrsets) firstAttrNameMatching;
  cfg = config.flake;
  monitorOpts = submodule {
    options = {
      id = mkStrOption "";
      resolution = mkStrOption "";
      refresh-rate = mkStrOption "";
      scale = mkStrOption "";
    };
  };
  userOpts = submodule {
    options = {
      username = mkStrOption "";
      primary = mkEnableOption "";
      name = mkStrOption "";
      email = mkStrOption "";
      shell = mkStrOption "";
      pubkey = mkStrOption "";
    };
  };
  hostOpts = submodule {
    options = {
      graphical = mkEnableOption "";
      machine = {
        platform = mkStrOption "";
        gpu = mkStrOption "";
        root.drive = mkStrOption "";
        monitors = mkOption {
          type = lazyAttrsOf monitorOpts;
          default = { };
        };
      };
      extraCfg = mkOption {
        type = deferredModule;
        default = { };
      };
    };
  };
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
    manifest = mkOption {
      type = submodule {
        options = {
          users = mkOption {
            type = lazyAttrsOf userOpts;
            default = { };
          };
          hosts.nixos = mkOption {
            type = lazyAttrsOf hostOpts;
            default = { };
          };
          hosts.darwin = mkOption {
            type = lazyAttrsOf raw;
            default = { };
          };
        };
      };
    };
    # Helper Option
    admin = mkOption {
      type = userOpts;
      default = { };
    };
  };
  config.flake =
    let
      username = firstAttrNameMatching (_: v: v.primary or false) cfg.manifest.users;
    in
    {
      paths.secrets = cfg.paths.root + "/secrets";
      admin = cfg.manifest.users.${username} // {
        inherit username;
      };
    };
}

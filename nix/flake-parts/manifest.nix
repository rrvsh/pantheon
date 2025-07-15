{ lib, config, ... }:
let
  cfg = config.flake;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types)
    bool
    str
    lazyAttrsOf
    deferredModule
    submodule
    ;
  inherit (cfg.lib.options) mkStrOption;
  inherit (cfg.lib.attrsets) firstAttrNameMatching;
  userOpts = submodule {
    options = {
      primary = mkOption { type = bool; };
      username = mkOption { type = str; };
      name = mkOption { type = str; };
      email = mkOption { type = str; };
      shell = mkOption { type = str; };
      pubkey = mkOption { type = str; };
    };
  };
  monitorOpts = submodule {
    options = {
      id = mkStrOption "";
      resolution = mkStrOption "";
      refresh-rate = mkStrOption "";
      scale = mkStrOption "";
    };
  };
  hostOpts = submodule {
    options = {
      graphical = mkEnableOption "";
      machine = {
        platform = mkStrOption "";
        gpu = mkStrOption "";
        root.drive = mkStrOption "";
        root.ephemeral = mkEnableOption "" // {
          default = true;
        };
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
  username = firstAttrNameMatching (_: v: v.primary or false) config.manifest.users;
in
{
  options.manifest = {
    admin = mkOption {
      type = userOpts;
      readOnly = true;
    };
    users = mkOption {
      type = lazyAttrsOf userOpts;
      default = { };
    };
    hosts.nixos = mkOption {
      type = lazyAttrsOf hostOpts;
      default = { };
    };
    hosts.darwin = mkOption {
      type = lazyAttrsOf hostOpts;
      default = { };
    };
  };
  config.manifest.admin = config.manifest.users.${username} // {
    inherit username;
  };
}

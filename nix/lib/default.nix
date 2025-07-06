{ lib, config, ... }:
let
  cfg = config.flake;
  inherit (lib.attrsets) mapAttrs concatMapAttrs;
in
{
  flake.lib = {
    flattenAttrs = attrset: concatMapAttrs (_: v: v) attrset;
    forAllUsers = f: mapAttrs f cfg.manifest.users;
  };
}

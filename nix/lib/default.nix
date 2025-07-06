{ lib, ... }:
let
  inherit (lib.attrsets) concatMapAttrs;
in
{
  flake.lib = {
    flattenAttrs = attrset: concatMapAttrs (_: v: v) attrset;
  };
}

{ lib, ... }:
let
  inherit (lib.modules) mkMerge;
  inherit (lib.attrsets) mapAttrsToList;
in
{
  flake.lib = {
    flattenAttrs = attrset: mkMerge (mapAttrsToList (_: v: v) attrset);
  };
}

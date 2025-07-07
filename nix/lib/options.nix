{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
in
{
  flake.lib.options = {
    mkStrOption =
      default:
      mkOption {
        inherit default;
        type = str;
      };
  };
}

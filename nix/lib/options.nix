{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    str
    path
    int
    port
    attrs
    ;
in
{
  flake.lib.options = {
    mkStrOption =
      default:
      mkOption {
        inherit default;
        type = str;
      };
    mkAttrOption =
      default:
      mkOption {
        inherit default;
        type = attrs;
      };
    mkIntOption =
      default:
      mkOption {
        inherit default;
        type = int;
      };
    mkPortOption =
      default:
      mkOption {
        type = port;
        inherit default;
      };
    mkPathOption =
      default:
      mkOption {
        type = path;
        inherit default;
      };
  };
}

{ lib, ... }:
{
  mkStrOption = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
  mkPortOption =
    port:
    lib.mkOption {
      type = lib.types.port;
      default = port;
    };
  mkPathOption =
    path:
    lib.mkOption {
      type = lib.types.path;
      default = path;
    };
}

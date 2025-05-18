{ lib, ... }:
{
  mkStrOption = lib.mkOption {
    type = lib.types.str;
    default = "";
  };
}

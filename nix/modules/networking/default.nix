{ lib, ... }:
let
  inherit (lib.modules) mkDefault;
in
{
  flake.modules.nixos.default =
    { hostName, ... }:
    {
      networking = {
        inherit hostName;
        enableIPv6 = false;
        useDHCP = mkDefault true;
        networkmanager.enable = true;
      };
    };
}

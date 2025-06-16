{ lib, ... }:
let
  inherit (lib) singleton;
in
{
  config = {
    services.fwupd.enable = true;
    persistDirs = singleton "/var/lib/bluetooth";
    hardware.bluetooth = {
      enable = true;
      settings.General.Experimental = true;
    };
    hardware.xone.enable = true;
  };
}

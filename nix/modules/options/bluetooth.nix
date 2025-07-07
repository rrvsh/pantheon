{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
in
{
  flake.modules.nixos.default = {
    options.bluetooth.enable = mkEnableOption "";
    config = {
      persistDirs = [ "/var/lib/bluetooth" ];
      hardware.bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };
    };
  };
}

{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
in
{
  flake.modules.nixos.default =
    { config, modulesPath, ... }:
    let
      cfg = config.machine;
    in
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
      options.machine = {
        bluetooth.enable = mkEnableOption "";
        usb.automount = mkEnableOption "";
      };
      config = mkMerge [
        (mkIf cfg.usb.automount {
          services.udisks2.enable = true;
          home-manager.sharedModules = [
            {
              services.udiskie = {
                enable = true;
                automount = true;
                notify = true;
              };
            }
          ];
        })
        (mkIf cfg.bluetooth.enable {
          persistDirs = [ "/var/lib/bluetooth" ];
          hardware.bluetooth = {
            enable = true;
            settings.General.Experimental = true;
          };
        })
      ];
    };
}

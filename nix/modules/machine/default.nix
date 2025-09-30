{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
in
{
  flake.modules.nixos.default =
    {
      config,
      modulesPath,
      pkgs,
      ...
    }:
    let
      cfg = config.machine;
    in
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
      options.machine = {
        bluetooth.enable = mkEnableOption "";
        usb.automount = mkEnableOption "";
        usb.qmk.enable = mkEnableOption "";
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
        (mkIf cfg.usb.qmk.enable {
          hardware.keyboard.qmk.enable = true;
          services.udev = {
            packages = with pkgs; [
              vial
              qmk
              qmk-udev-rules
              qmk_hid
            ];
          };

        })
        (mkIf cfg.bluetooth.enable {
          persistDirs = [ "/var/lib/bluetooth" ];
          hardware.bluetooth = {
            enable = true;
            settings.General.Experimental = true;
          };
        })
        {
          boot.binfmt.emulatedSystems = [ "aarch64-linux"];
        }
      ];
    };
}

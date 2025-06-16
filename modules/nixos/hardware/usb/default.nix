{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    singleton
    ;
  cfg = config.hardware.usb;
in
{
  options.hardware.usb = {
    automount = mkEnableOption "";
    enableQmk = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf cfg.automount {
      services.udisks2.enable = true;
      home-manager.sharedModules = singleton {
        services.udiskie = {
          enable = true;
          automount = true;
          notify = true;
        };
      };
    })
    (mkIf cfg.enableQmk {
      hardware.keyboard.qmk.enable = true;
      services.udev = {
        packages = with pkgs; [
          vial
          via
          qmk
          qmk-udev-rules
          qmk_hid
        ];
      };
    })
  ];
}

{
  config,
  lib,
  ...
}:
let
  inherit (lib.pantheon) mkStrOption;
  cfg = config.machine.bootloader;
in
{
  options.machine.bootloader = {
    type = mkStrOption;
  };
  config = lib.mkMerge [
    {
      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.loader.efi.canTouchEfiVariables = true;
    }
    (lib.mkIf (config.machine.bootloader.type == "systemd-boot") {
      boot.loader.systemd-boot.enable = true;
    })
  ];
}

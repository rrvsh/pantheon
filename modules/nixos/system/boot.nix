{ config, lib, ... }:
{
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
    (lib.mkIf (config.system.bootloader == "systemd-boot") {
      boot.loader.systemd-boot.enable = true;
    })
  ];
}

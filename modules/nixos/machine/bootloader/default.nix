{
  config,
  lib,
  ...
}:
let
  inherit (lib.pantheon) mkIntOption mkStrOption;
  cfg = config.machine.bootloader;
in
{
  options.machine.bootloader = {
    type = mkStrOption;
    configurationLimit = mkIntOption 5;
  };
  config.boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = cfg.type == "systemd-boot";
      inherit (cfg) configurationLimit;
    };
  };
}

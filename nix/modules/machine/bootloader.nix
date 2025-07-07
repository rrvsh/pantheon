{
  flake.modules.nixos.default.boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    loader.efi.canTouchEfiVariables = true;
    #TODO: disable for mbp?
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };
}

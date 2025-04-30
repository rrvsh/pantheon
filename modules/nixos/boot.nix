{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  moduleName = "boot-config";
  cfg = config."${moduleName}";
in
{
  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
      bootloader = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "systemd-boot";
        description = "What bootloader to use.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      loader =
        {
          timeout = 5;
          efi.canTouchEfiVariables = true;
        }
        // lib.mkIf (cfg.bootloader == "systemd-boot") {
          systemd-boot.enable = true;
          systemd-boot.configurationLimit = 5;
        };
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      initrd.availableKernelModules = [
        "9p"
        "9pnet_virtio"
        "ahci"
        "nvme"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "sr_mod"
        "usb_storage"
        "usbhid"
        "virtio_blk"
        "virtio_mmio"
        "virtio_net"
        "virtio_pci"
        "virtio_scsi"
        "xhci_pci"
      ];
    };
    services.dbus = {
      enable = true;
    };
  };
}

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
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
        "rtsx_pci_sdmmc"
      ];
    };
    services.dbus = {
      enable = true;
    };
  };
}

{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption singleton;
  cfg = config.hardware;
in
{
  imports = [
    ./btrfs.nix
    ./nvidia.nix
    ./audio.nix
    ./networking.nix
  ];

  options.hardware = {
    drives.btrfs = {
      enable = lib.mkEnableOption "";
      drive = lib.pantheon.mkStrOption;
      ephemeralRoot = lib.mkEnableOption "";
    };
    gpu = lib.pantheon.mkStrOption;
    platform = lib.pantheon.mkStrOption;
    usb = {
      automount = mkEnableOption "";
    };
  };

  config = lib.mkMerge [
    (mkIf cfg.usb.automount {
      services.udisks2.enable = true;
      home-manager.sharedModules = singleton {
        services.udiskie = {
          enable = true;
          automount = true;
          notify = true;
        };
      };
    })
    {
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
      services.fwupd.enable = true;
      persistDirs = singleton "/var/lib/bluetooth";
      hardware.bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };
      hardware.xone.enable = true;
    }
    (lib.mkIf (config.hardware.platform == "amd") {
      hardware.cpu.amd.updateMicrocode = true;
      boot.kernelModules = [ "kvm-amd" ];
    })
    (lib.mkIf (config.hardware.platform == "intel") {
      hardware.cpu.intel.updateMicrocode = true;
      boot.kernelModules = [ "kvm-intel" ];
    })
  ];
}

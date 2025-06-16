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
  };

  config = lib.mkMerge [
    {
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

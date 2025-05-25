{ lib, ... }:
{
  imports = [
    ./btrfs.nix
    ./nvidia.nix
    ./audio.nix
    ./cpu.nix
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

  config = {
    services.fwupd.enable = true;
    hardware.bluetooth = {
      enable = true;
      settings.General.Experimental = true;
    };
    hardware.xone.enable = true;
  };
}

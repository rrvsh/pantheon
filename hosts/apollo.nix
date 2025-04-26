{ lib, config, ... }:
{
  imports = [
    ../configs/filesystems/impermanence.nix
    ../configs/services.nix
  ];
  boot.kernelModules = [ "kvm-intel" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  boot-config.bootloader = "systemd-boot";
}

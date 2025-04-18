{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    ../configs/bootloaders/systemd-boot.nix
    ../configs/filesystems/impermanence.nix
    ../configs/hardware/nvidia.nix
    inputs.nixos-hardware.nixosModules.gigabyte-b650
  ];
  boot.kernelModules = [ "kvm-intel" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

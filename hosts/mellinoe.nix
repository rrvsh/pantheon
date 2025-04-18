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
    inputs.nixos-hardware.nixosModules.microsoft-surface-go
  ];
  boot.kernelModules = [ "kvm-intel" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

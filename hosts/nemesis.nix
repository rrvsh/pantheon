{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    ../configs/bootloaders/systemd-boot.nix
    ../configs/filesystems/hw-nemesis.nix
    ../configs/hardware/nvidia.nix
    ../configs/hardware/powermanagement.nix
    inputs.nixos-hardware.nixosModules.gigabyte-b650
  ];
  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

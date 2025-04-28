{ inputs, ... }:
{
  imports = [
    ../configs/filesystems/hw-nemesis.nix
    ../configs/hardware/powermanagement.nix
    inputs.nixos-hardware.nixosModules.gigabyte-b650
  ];
  boot-config.bootloader = "systemd-boot";
  hardware-config.cpu = "amd";
  hardware-config.gpu = "nvidia";
  gaming.steam.enable = true;
  fs-config.mountHeliosData = true;
  nw-config.wol.enable = true;
  nw-config.wol.interface = "enp12s0";
}

{ pkgs, ... }:
{
  imports = [
    ./hw-nemesis.nix
    ./modules/common.nix
    ./modules/desktop.nix
    ./modules/bootloaders/systemd-boot.nix
    ./modules/hardware/nvidia.nix
    ./modules/hardware/bluetooth.nix
  ];

  networking.hostName = "nemesis";
  system.stateVersion = "24.11";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

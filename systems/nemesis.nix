{ pkgs, ... }:
{
  imports = [
    ./hw-nemesis.nix
    ./common.nix
    ./desktop.nix
    ./modules/hardware/nvidia.nix
  ];

  networking.hostName = "nemesis";
  system.stateVersion = "24.11";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

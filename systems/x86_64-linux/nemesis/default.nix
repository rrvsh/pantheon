{ config, lib, pkgs, ... }:
{
  system.mainUser = "rafiq";
  system.bootloader = "systemd-boot";
  hardware.drives.btrfs = {
    enable = true;
    drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
    ephemeralRoot = true;
  };
  hardware.platform = "amd";
  hardware.gpu = "nvidia";


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";



  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "nemesis"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


}


# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../modules/common.nix
      ./hardware-configuration.nix
      ../../scripts/hyprland-tty-launch.nix
      ../../modules/nvidia.nix # Graphics settings for Nvidia GPUs
      ../../modules/networking.nix # Common networking config
      ../../modules/wm-hyprland.nix # Enable the hyprland wm
    ];

  networking.hostName = "nemesis";

  # Allow nemesis to access files on the windows drive.
  fileSystems."/mnt/windows" =
    { device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=rafiq" ];
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    koboldcpp
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

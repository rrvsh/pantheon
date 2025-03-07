{
  imports = [
    ./hw-nemesis.nix
    ./modules/common.nix # Common options for all systems
    ./modules/systemd-boot.nix # Systemd-boot as bootloader
    ./modules/locale.nix # SG locale settings
    ./modules/fonts.nix # Fonts
    ./modules/networking.nix # Common networking settings
    ./modules/hyprland.nix # Hyprland compositor
    ./modules/nvidia.nix # Nvidia settings
    ./modules/personalisation.nix
  ];

  networking.hostName = "nemesis";

  system.stateVersion = "24.11";
}

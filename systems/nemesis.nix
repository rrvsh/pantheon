{
  imports = [
    ./hw-nemesis.nix
    ./modules/common.nix
    ./modules/systemd-boot.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/hyprland.nix
  ];

  networking.hostName = "nemesis";

  system.stateVersion = "24.11";
}

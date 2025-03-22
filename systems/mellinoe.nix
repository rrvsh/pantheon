{
  imports = [
    ./hw-mellinoe.nix
    ./modules/common.nix
    ./modules/desktop.nix
    ./modules/bootloaders/systemd-boot.nix
    ./modules/hardware/bluetooth.nix
  ];
  networking.hostName = "mellinoe";
  system.stateVersion = "24.11";
}

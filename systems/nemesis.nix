{
  imports = [
    ./hw-nemesis.nix
    ./modules/bootloaders/systemd-boot.nix
    ./modules/common.nix
    ./modules/hardware/nvidia.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/stylix.nix
  ];

  networking.hostName = "nemesis";

  boot.binfmt.emulatedSystems = ["wasm32-wasi" "x86_64-windows" "aarch64-linux"];

  system.stateVersion = "24.11";
}

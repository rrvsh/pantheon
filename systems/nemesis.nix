{
  imports = [
    ./hw-nemesis.nix
    ./modules/common.nix
    ./modules/desktop.nix
    ./modules/bootloaders/systemd-boot.nix
    ./modules/hardware/nvidia.nix
  ];

  networking.hostName = "nemesis";
  system.stateVersion = "24.11";
  boot.binfmt.emulatedSystems = ["wasm32-wasi" "x86_64-windows" "aarch64-linux"];
}

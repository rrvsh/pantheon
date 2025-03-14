{inputs, ...}: {
  imports = [
    ./hw-orpheus.nix
    ./modules/bootloaders/extlinux.nix
    ./modules/common.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    "${inputs.nixpkgs}/nixos/modules/profiles/minimal.nix"
  ];

  networking.hostName = "orpheus";
  system.stateVersion = "25.05";
}

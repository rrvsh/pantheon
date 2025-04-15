{
  imports = [
    ../configs/bootloaders/systemd-boot.nix
    ../configs/filesystems/impermanence.nix
    ../configs/hardware/cpu_intel.nix
    ../configs/services.nix
  ];
}

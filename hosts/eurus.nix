{
  imports = [
    ../configs/filesystems/impermanence.nix
  ];
  boot-config.bootloader = "systemd-boot";
  hardware-config.cpu = "amd";
}

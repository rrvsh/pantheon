{
  imports = [
    ../configs/filesystems/impermanence.nix
    ../configs/services.nix
  ];
  boot-config.bootloader = "systemd-boot";
  hardware-config.cpu = "intel";
  service-glance.enable = true;
}

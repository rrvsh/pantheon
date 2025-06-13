{
  imports = [
    ../common.nix
    ../desktop.nix
  ];

  system = {
    hostname = "mellinoe";
    bootloader = "systemd-boot";
  };

  hardware = {
    drives.btrfs = {
      enable = true;
      drive = "/dev/disk/by-id/nvme-KBG40ZPZ128G_TOSHIBA_MEMORY_Z0U103PCNCDL";
      ephemeralRoot = true;
    };
    platform = "intel";
  };
}

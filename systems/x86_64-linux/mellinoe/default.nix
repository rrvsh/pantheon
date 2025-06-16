{
  imports = [
    ../common.nix
    ../desktop.nix
  ];
  hostname = "mellinoe";

  machine = {
    platform.type = "intel";
    bootloader.type = "systemd-boot";
    drives.btrfs = {
      enable = true;
      drive = "/dev/disk/by-id/nvme-KBG40ZPZ128G_TOSHIBA_MEMORY_Z0U103PCNCDL";
      ephemeralRoot = true;
    };
  };

  desktop.mainMonitor = {
    id = "BOE 0x088B";
    scale = "2";
    resolution = "1920x1280";
    refresh-rate = "60";
  };
}

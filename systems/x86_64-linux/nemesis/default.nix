{
  imports = [
    ../common.nix
    ../desktop.nix
  ];

  system = {
    hostname = "nemesis";
    bootloader = "systemd-boot";
  };

  hardware = {
    drives.btrfs = {
      enable = true;
      drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
      ephemeralRoot = true;
    };
    platform = "amd";
    gpu = "nvidia";
  };

  services = {
    tor = {
      enable = true;
      client.enable = true;
    };
  };
}

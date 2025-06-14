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
    usb.automount = true;
  };

  desktop = {
    browser.tor-browser.enable = true;
    services = {
      steam.enable = true;
      sunshine.enable = true;
      spotifyd.enable = true;
    };
    mainMonitor = {
      id = "desc:OOO AN-270W04K";
      scale = "2";
      resolution = "3840x2160";
      refresh-rate = "60";
    };
  };

  services = {
    sd-webui-forge = {
      enable = true;
      listen = true;
      extraArgs = "--cuda-malloc";
    };
  };
}

{
  imports = [
    ../common.nix
    ../desktop.nix
  ];
  hostname = "nemesis";

  machine = {
    platform.type = "amd";
    gpu.nvidia.enable = true;
    bootloader.type = "systemd-boot";
    drives.btrfs = {
      enable = true;
      drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
      ephemeralRoot = true;
    };
    virtualisation.podman.enable = true;
  };

  desktop = {
    browser.tor-browser.enable = true;
    gaming = {
      prism-launcher.enable = true;
      steam.enable = true;
    };
    services = {
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

  server.web-apps.sd-webui-forge.enable = true;
}

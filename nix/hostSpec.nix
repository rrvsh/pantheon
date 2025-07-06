let
  testCfg = {
    fileSystems."/" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
    nixpkgs.hostPlatform = "x86_64-linux";
  };
in
{
  flake.hostSpec.hosts = {
    "nixos/test".extraCfg = testCfg;
    "nixos/nemesis" = {
      machine = {
        platform = "amd";
        gpu = "nvidia";
        root.drive = "/dev/disk/by-id/nvme-CT2000P3SSD8_2325E6E77434";
        monitors = [
          {
            id = "desc:OOO AN-270W04K";
            scale = "2";
            resolution = "3840x2160";
            refresh-rate = "60";
          }
        ];
      };
      # profiles = with config.flake.profiles.nixos; [
      #   graphical
      #   development
      # ];
      # extraModules = with config.flakes.modules.nixos; [
      #   sunshine
      #   sd-webui-forge
      #   comfy-ui
      # ];
      extraCfg = testCfg;
    };
    "nixos/apollo" = {
      machine = {
        platform = "intel";
        root.drive = "/dev/disk/by-id/nvme-eui.002538d221b47b01";
      };
      # profiles = with config.flake.profiles.nixos; [ headless ];
      # extraModules = with config.flakes.modules.nixos; [
      #   librechat
      #   forgejo
      #   rrv-sh
      # ];
      extraCfg = testCfg;
    };
  };
}

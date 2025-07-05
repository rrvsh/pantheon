{ config, ... }:
{
  flake.hostSpec.hosts = {
    "nixos/test".extraCfg = {
      imports = with config.flake.modules.nixos; [ networking ];
      config = {
        boot.loader.systemd-boot.enable = true;
        fileSystems."/" = {
          device = "/dev/sda1";
          fsType = "ext4";
        };
        nixpkgs.hostPlatform = "x86_64-linux";
        system.stateVersion = "25.05";
      };
    };
  };
}

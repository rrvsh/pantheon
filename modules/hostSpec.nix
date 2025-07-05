{
  flake.hostSpec.hosts."nixos/test".extraCfg = {
    fileSystems."/" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}

{lib,...}:
{
  imports = [
    ./btrfs.nix
    ./nvidia.nix
    ./audio.nix
    ./cpu.nix
  ];

  options.hardware = {
    drives.btrfs = {
      enable = lib.mkEnableOption "";
      drive = lib.pantheon.mkStrOption;
      ephemeralRoot = lib.mkEnableOption "";
    };
    gpu = lib.pantheon.mkStrOption;
    platform = lib.pantheon.mkStrOption;
  };
}

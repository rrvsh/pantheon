{lib,...}:
{
  imports = [
    ./btrfs.nix
    ./nvidia.nix
  ];

  options.hardware = {
    drives.btrfs = {
      enable = lib.mkEnableOption "";
      drive = lib.mkOption {
        type = lib.types.str;
        default = "";
      }; 
      ephemeralRoot = lib.mkEnableOption "";
    };
    gpu = lib.mkOption {
      type = lib.types.str;
        default = "";
    };
  };
}

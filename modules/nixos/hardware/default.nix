{lib,...}:
{
  imports = [
    ./btrfs.nix
  ];

  options = {
    hardware.drives.btrfs.enable = lib.mkEnableOption "";
    hardware.drives.btrfs.drive = lib.mkOption {
      type = lib.types.str;
      default = "";
    }; 
    hardware.drives.btrfs.ephemeralRoot = lib.mkEnableOption "";
  };
}

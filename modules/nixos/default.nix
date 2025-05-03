{
  config,
  lib,
  ...
}:
let
  moduleName = "nixosModules";
  cfg = config."${moduleName}";
in
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./nix-config.nix
    ./gaming.nix
    ./filesystems.nix
    ./networking.nix
    ./services/glance.nix
  ];

  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
      hostname = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "goron";
        description = "The name this machine will be known by.";
      };
      mainUser = lib.mkOption {
        type = lib.types.str;
        default = "";
        example = "link";
        description = "The main user of pantheon.";
      };
    };
  };

  config = lib.mkIf cfg.enable { };
}

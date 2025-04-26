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
  ];

  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
    };
  };

  config = lib.mkIf cfg.enable { };
}

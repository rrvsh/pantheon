{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "nixosModules";
  cfg = config."${moduleName}";
in
{
  imports = [
    ./nix-config.nix
  ];

  options = {
    "${moduleName}".enable = lib.mkEnableOption "Enable ${moduleName}.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ micro ];
  };
}

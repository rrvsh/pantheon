{
  inputs,
  config,
  specialArgs,
  lib,
  ...
}:
let
  moduleName = "hmModules";
  cfg = config."${moduleName}";
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = specialArgs;
      users.rafiq.home = {
        username = "rafiq";
        homeDirectory = "/home/rafiq";
        stateVersion = "25.05";
      };
    };
  };
}

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
  username = config.nixosModules.mainUser;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
  ];

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
      users."${username}".home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
    };
  };
}

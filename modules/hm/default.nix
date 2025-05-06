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
    ./programs/editor.nix
  ];

  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
      mainApps = {
        terminal = lib.mkOption {
          type = lib.types.str;
          default = "kitty";
          example = "kitty";
          description = "What terminal is the default.";
        };
        browser = lib.mkOption {
          type = lib.types.str;
          default = "firefox";
          example = "firefox";
          description = "What browser is the default.";
        };
        editor = lib.mkOption {
          type = lib.types.str;
          default = "nvf";
          example = "nvf";
          description = "What editor is the default.";
        };
        launcher = lib.mkOption {
          type = lib.types.str;
          default = "fuzzel";
          example = "fuzzel";
          description = "What launcher is the default.";
        };
      };
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

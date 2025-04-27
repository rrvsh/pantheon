{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  moduleName = "gaming";
  cfg = config."${moduleName}";
in
{
  options = {
    "${moduleName}" = {
      steam = {
        enable = lib.mkEnableOption "Enable Steam.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.steam.enable {
      programs.steam.enable = true;
      environment.systemPackages = with pkgs; [
        steam-run
        wineWowPackages.stable
        wine64
        wineWowPackages.waylandFull
        protonup
        lutris
        heroic
        bottles
      ];
      environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };
    })
  ];
}

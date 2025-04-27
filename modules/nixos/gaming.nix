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
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options = {
    "${moduleName}" = {
      steam = {
        enable = lib.mkEnableOption "Enable Steam.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.steam.enable {
      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
          protontricks.enable = true;
          dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
          localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
          gamescopeSession.enable = true;
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
          platformOptimizations.enable = true;
        };
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        gamemode.enable = true;
      };
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

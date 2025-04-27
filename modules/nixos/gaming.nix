{
  config,
  lib,
  pkgs,
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
        enableGamescope = lib.mkEnableOption "Enable the gamescope compositor.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.steam.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        protontricks.enable = true;
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      environment.systemPackages = with pkgs; [
        steam-run
      ];
    })
    (lib.mkIf cfg.steam.enableGamescope {
      programs.steam.gamescopeSession.enable = true;
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };
    })
  ];
}

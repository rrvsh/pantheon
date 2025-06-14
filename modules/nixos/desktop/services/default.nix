{ config, lib, ... }:
let
  inherit (lib)
    mkMerge
    singleton
    mkEnableOption
    mkIf
    ;
  cfg = config.desktop.services;
in
{
  options.desktop.services = {
    spotifyd.enable = mkEnableOption "";
    sunshine.enable = mkEnableOption "";
    steam.enable = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf cfg.sunshine.enable {
      services.sunshine = {
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
        settings = {
          sunshine_name = config.system.hostname;
          origin_web_ui_allowed = "wan";
        };
        applications = { };
      };
      home-manager.sharedModules = singleton { persistDirs = singleton ".config/sunshine"; };
    })
    (mkIf cfg.spotifyd.enable {
      networking.firewall.allowedTCPPorts = [ 5353 ];
      networking.firewall.allowedUDPPorts = [ 5353 ];
      home-manager.sharedModules = singleton {
        services.spotifyd.enable = true;
        services.spotifyd.settings.global = {
          device_name = "${config.system.hostname}";
          device_type = "computer";
          zeroconf_port = 5353;
        };
      };
    })
  ];
}

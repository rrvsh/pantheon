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
  };

  config = mkMerge [
    (mkIf cfg.spotifyd.enable {
      networking.firewall.allowedTCPPorts = [ 5353 ];
      networking.firewall.allowedUDPPorts = [ 5353 ];
      home-manager.sharedModules = singleton {
        services.spotifyd.enable = true;
        services.spotifyd.settings.global = {
          device_name = "${config.hostname}";
          device_type = "computer";
          zeroconf_port = 5353;
        };
      };
    })
  ];
}

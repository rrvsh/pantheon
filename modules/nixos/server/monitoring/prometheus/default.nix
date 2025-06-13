{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.pantheon) mkPortOption;
  cfg = config.server.monitoring.prometheus;
  upstreamCfg = config.services.prometheus;
in
{
  options.server.monitoring.prometheus = {
    enable = mkEnableOption "";
    port = mkPortOption 9090;
  };

  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      inherit (cfg) port;
      scrapeConfigs = [
        {
          job_name = "chrysalis";
          static_configs = [
            {
              targets = [ "127.0.0.1:${toString upstreamCfg.exporters.node.port}" ];
            }
          ];
        }
      ];

      exporters.node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9091;
      };
    };
  };
}

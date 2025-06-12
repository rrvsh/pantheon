{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.pantheon) mkPortOption;
  cfg = config.server.monitoring.prometheus;
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
    };
  };
}

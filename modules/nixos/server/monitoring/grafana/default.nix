{ config, lib, ... }:
let
  inherit (lib) singleton mkEnableOption mkIf;
  inherit (lib.pantheon) mkRootDomain mkPortOption mkStrOption;
  cfg = config.server.monitoring.grafana;
in
{
  options.server.monitoring.grafana = {
    enable = mkEnableOption "";
    url = mkStrOption;
    port = mkPortOption 3000;
  };

  config = mkIf cfg.enable {
    server.networking.ddns.domains = singleton (mkRootDomain cfg.url);
    server.web-servers.nginx.proxies = mkIf config.server.web-servers.nginx.enable (singleton {
      source = cfg.url;
      target = "http://${config.system.hostname}:${builtins.toString cfg.port}";
      extraConfig.proxyWebsockets = true;
    });
    services.grafana = {
      enable = true;
      settings.server = {
        domain = cfg.url;
        http_port = cfg.port;
        http_addr = "0.0.0.0";
      };
    };
  };
}

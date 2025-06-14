{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf singleton;
  inherit (lib.pantheon) mkRootDomain mkStrOption mkPortOption;
  cfg = config.server.web-apps.forgejo;
  upstreamCfg = config.services.forgejo;
in
{
  options.server.web-apps.forgejo = {
    enable = mkEnableOption "";
    url = mkStrOption;
    port = mkPortOption 3000;
  };

  config = mkIf cfg.enable {
    persistDirs = singleton {
      directory = upstreamCfg.stateDir;
      inherit (upstreamCfg) user group;
    };
    server.networking.ddns.domains = singleton (mkRootDomain cfg.url);
    server.web-servers.nginx.proxies = mkIf config.server.web-servers.nginx.enable (singleton {
      source = cfg.url;
      target = "http://${config.system.hostname}:${builtins.toString cfg.port}";
    });
    services.forgejo = {
      enable = true;
      settings.server = {
        DOMAIN = cfg.url;
        ROOT_URL = "https://${cfg.url}/";
        HTTP_PORT = cfg.port;
      };
    };
  };
}

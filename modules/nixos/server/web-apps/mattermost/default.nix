{ config, lib, ... }:
let
  cfg = config.server.web-apps.mattermost;
  upstreamCfg = config.services.mattermost;
  mkDir = directory: {
    inherit directory;
    inherit (upstreamCfg) user group;
    mode = "0750";
  };
in
{
  options.server.web-apps.mattermost = {
    enable = lib.mkEnableOption "the Mattermost service";
    port = lib.pantheon.mkPortOption 8065;
    url = lib.pantheon.mkStrOption;
    configDir = lib.pantheon.mkStrOption // {
      default = "/etc/mattermost";
    };
    dataDir = lib.pantheon.mkStrOption // {
      default = "/var/lib/mattermost";
    };
    logDir = lib.pantheon.mkStrOption // {
      default = "/var/log/mattermost";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.services.postgresql.enable;
        message = "You must enable a local instance of postgresql.";
      }
    ];
    environment.persistence."/persist".directories = [
      (mkDir cfg.configDir)
      (mkDir cfg.logDir)
      (mkDir cfg.dataDir)
    ];
    networking.firewall.allowedTCPPorts = lib.singleton cfg.port;
    services.mattermost = {
      enable = true;
      inherit (cfg)
        configDir
        dataDir
        logDir
        port
        ;
      host = "0.0.0.0";
      siteName = "pantheon";
      siteUrl = "https://${cfg.url}";
    };
    services.postgresql = {
      ensureDatabases = lib.singleton upstreamCfg.database.name;
      ensureUsers = lib.singleton {
        name = upstreamCfg.database.user;
        ensureDBOwnership = true;
      };
    };
    server.web-servers.nginx.proxies = lib.mkIf config.server.web-servers.nginx.enable (
      lib.singleton {
        source = cfg.url;
        target = "http://${config.system.hostname}:${builtins.toString cfg.port}";
      }
    );
  };
}

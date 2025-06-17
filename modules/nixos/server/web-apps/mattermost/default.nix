{ config, lib, ... }:
let
  inherit (lib) singleton;
  inherit (lib.pantheon) mkStrOption;
  inherit (lib.pantheon.modules) mkWebApp;
  cfg = config.server.web-apps.mattermost;
  upstreamCfg = config.services.mattermost;
  mkDir = directory: {
    inherit directory;
    inherit (upstreamCfg) user group;
    mode = "0750";
  };
in
mkWebApp {
  inherit config;
  name = "mattermost";
  defaultPort = 8065;
  persistDirs = [
    (mkDir cfg.configDir)
    (mkDir cfg.logDir)
    (mkDir cfg.dataDir)
  ];
  extraOptions = {
    teamName = mkStrOption;
    configDir = mkStrOption // {
      default = "/etc/mattermost";
    };
    dataDir = mkStrOption // {
      default = "/var/lib/mattermost";
    };
    logDir = mkStrOption // {
      default = "/var/log/mattermost";
    };
  };
  extraConfig = {
    assertions = [
      {
        assertion = config.services.postgresql.enable;
        message = "You must enable a local instance of postgresql.";
      }
    ];
    services.mattermost = {
      enable = true;
      inherit (cfg)
        configDir
        dataDir
        logDir
        port
        ;
      host = "0.0.0.0";
      siteUrl = "https://${cfg.domain}";
    };
    services.matterbridge = {
      enable = true;
      inherit (upstreamCfg) user group;
      configPath = config.sops.templates."matterbridge-conf".path;
    };
    sops.secrets."matterbridge/mattermost-password" = { };
    sops.templates."matterbridge-conf" = {
      owner = upstreamCfg.user;
      content = # toml
        ''
          [[gateway]]
          name="gateway1"
          enable=true

          [[gateway.inout]]
          account="mattermost.${config.hostname}"
          channel="matterbridge"

          [mattermost.${config.hostname}]
          Server="${cfg.domain}"
          Team="${cfg.teamName}"
          Login="matterbridge"
          Password="${config.sops.placeholder."matterbridge/mattermost-password"}"
          RemoteNickFormat="[{PROTOCOL}] <{NICK}> "
          PrefixMessagesWithNick=true
          PreserveThreading=true
        '';
    };
    services.nginx.virtualHosts.${cfg.domain}.locations."~ /api/v[0-9]+/(users/)?websocket$" = {
      proxyPass = "http://${config.hostname}:${toString cfg.port}";
      proxyWebsockets = true;
    };
    services.postgresql = {
      ensureDatabases = singleton upstreamCfg.database.name;
      ensureUsers = singleton {
        name = upstreamCfg.database.user;
        ensureDBOwnership = true;
      };
    };
  };
}

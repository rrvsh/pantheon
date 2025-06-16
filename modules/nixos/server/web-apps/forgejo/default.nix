{ config, lib, ... }:
let
  inherit (lib) singleton;
  inherit (lib.pantheon.modules) mkWebApp;
  cfg = config.server.web-apps.forgejo;
  upstreamCfg = config.services.forgejo;
in
mkWebApp {
  inherit config;
  name = "forgejo";
  defaultPort = 3000;
  persistDirs = singleton {
    directory = upstreamCfg.stateDir;
    inherit (upstreamCfg) user group;
  };
  extraConfig = {
    services.forgejo = {
      enable = true;
      settings = {
        server = {
          DOMAIN = cfg.domain;
          ROOT_URL = "https://${cfg.domain}/";
          HTTP_PORT = cfg.port;
        };
        "repository.signing".FORMAT = "ssh";
      };
    };
  };
}

{ config, lib, ... }:
let
  inherit (lib) singleton optional;
  inherit (lib.pantheon) mkPortOption;
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
  extraOptions = {
    sshPort = mkPortOption 2222;
  };
  extraConfig = {
    networking.firewall.allowedTCPPorts = optional cfg.openFirewall cfg.sshPort;
    services.forgejo = {
      enable = true;
      settings = {
        server = {
          DOMAIN = cfg.domain;
          ROOT_URL = "https://${cfg.domain}/";
          HTTP_PORT = cfg.port;
          START_SSH_SERVER = true;
          SSH_PORT = cfg.sshPort;
        };
        repository = {
          USE_COMPAT_SSH_URI = false;
          ENABLE_PUSH_CREATE_USER = true;
          ENABLE_PUSH_CREATE_ORG = true;
        };
        "repository.signing".FORMAT = "ssh";
      };
    };
  };
}

{ lib, config, ... }:
let
  inherit (lib.pantheon.modules) mkWebApp;
  cfg = config.server.web-apps.glance;
in
mkWebApp {
  inherit config;
  name = "glance";
  defaultPort = 8080;
  extraConfig = {
    services.glance = {
      enable = true;
      settings.server.host = "0.0.0.0";
      settings.server.port = cfg.port;
    };
  };
}

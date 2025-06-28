{ config, lib, ... }:
let
  inherit (lib.pantheon.modules) mkWebApp;
  cfg = config.server.web-apps.rrv-sh;
in
mkWebApp {
  inherit config;
  name = "rrv-sh";
  defaultPort = 2309;
  extraConfig = {
    services.rrv-sh = {
      enable = true;
      inherit (cfg) port;
    };
  };
}

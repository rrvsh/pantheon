{ lib, config, ... }:
let
  inherit (lib.lists) singleton;
  inherit (config.flake.lib.services) mkWebApp;
  inherit (config.flake.paths) secrets;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    let
      upstreamCfg = config.services.firefly-iii;
    in
    mkWebApp {
      inherit config;
      name = "firefly-iii";
      defaultPort = 8080;
      persistDirs = singleton {
        directory = upstreamCfg.dataDir;
        inherit (upstreamCfg) user group;
      };
      extraConfig = {
        sops.secrets."firefly-iii/app-key".sopsFile = secrets + "/firefly-iii.yaml";
        services.firefly-iii = {
          enable = true;
          settings = {
            APP_ENV = "local";
            APP_KEY_FILE = config.sops.secrets."firefly-iii/app-key".path;
            APP_URL = "https://budget.bwfiq.com";
          };
        };
      };
    };
}

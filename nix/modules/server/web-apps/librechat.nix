{
  lib,
  inputs,
  config,
  ...
}:
let
  inherit (lib.lists) singleton;
  inherit (config.flake.lib.options) mkStrOption;
  inherit (config.flake.lib.services) mkWebApp;
  inherit (config.flake.paths) secrets;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    let
      cfg = config.server.web-apps.librechat;
      upstreamCfg = config.services.librechat;
    in
    mkWebApp {
      inherit config;
      name = "librechat";
      defaultPort = 3080;
      persistDirs = singleton {
        directory = upstreamCfg.dataDir;
        inherit (upstreamCfg) user group;
      };
      extraOptions.mongodbURI = mkStrOption "mongodb://${config.networking.hostName}:27017/LibreChat";
      extraConfig = {
        sops.secrets = {
          "librechat/creds_key".sopsFile = secrets + "/librechat.yaml";
          "librechat/creds_iv".sopsFile = secrets + "/librechat.yaml";
          "librechat/jwt_secret".sopsFile = secrets + "/librechat.yaml";
          "librechat/jwt_refresh_secret".sopsFile = secrets + "/librechat.yaml";
          "keys/gemini".sopsFile = secrets + "/keys.yaml";
          "keys/openrouter".sopsFile = secrets + "/keys.yaml";
        };
        services.librechat = {
          enable = true;
          openFirewall = true;
          inherit (cfg) port;
          env = {
            HOST = "0.0.0.0";
            ALLOW_REGISTRATION = "true";
            NO_INDEX = "true";
            MONGO_URI = cfg.mongodbURI;
            DOMAIN_CLIENT = cfg.domain;
            DOMAIN_SERVER = cfg.domain;
            ENDPOINTS = "anthropic,agents,google";
          };
          credentials = {
            CREDS_KEY = config.sops.secrets."librechat/creds_key".path;
            CREDS_IV = config.sops.secrets."librechat/creds_iv".path;
            JWT_SECRET = config.sops.secrets."librechat/jwt_secret".path;
            JWT_REFRESH_SECRET = config.sops.secrets."librechat/jwt_refresh_secret".path;
            OPENROUTER_KEY = config.sops.secrets."keys/openrouter".path;
            GOOGLE_KEY = config.sops.secrets."keys/gemini".path;
          };
          settings = {
            version = "1.1.4";
            cache = true;
            endpoints.custom = [
              {
                name = "OpenRouter";
                apiKey = "\${OPENROUTER_KEY}";
                baseURL = "https://openrouter.ai/api/v1";
                models.default = [ "meta-llama/llama-3-70b-instruct" ];
                models.fetch = true;
                titleConvo = true;
                titleModel = "current_model";
                modelDisplayLabel = "OpenRouter";
              }
            ];
            interface = {
              privacyPolicy = {
                externalUrl = "https://librechat.ai/privacy-policy";
                openNewTab = true;
              };
            };
          };
        };
      };
    }
    // {
      imports = singleton "${inputs.rrvsh-nixpkgs}/nixos/modules/services/web-apps/librechat.nix";
    };
}

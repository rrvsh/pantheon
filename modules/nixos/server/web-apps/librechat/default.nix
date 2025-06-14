{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) singleton mkEnableOption mkIf;
  inherit (lib.pantheon) mkRootDomain mkPortOption mkStrOption;
  cfg = config.server.web-apps.librechat;
  upstreamCfg = config.services.librechat;
in
{
  imports = singleton "${inputs.rrvsh-nixpkgs}/nixos/modules/services/web-apps/librechat.nix";

  options.server.web-apps.librechat = {
    enable = mkEnableOption "";
    port = mkPortOption 3080;
    url = mkStrOption;
    mongodbURI = mkStrOption // {
      default = "mongodb://${config.system.hostname}:27017/LibreChat";
    };
  };

  config = mkIf cfg.enable {
    persistDirs = singleton {
      directory = upstreamCfg.logDir;
      inherit (upstreamCfg) user group;
    };
    server.networking.ddns.domains = singleton (mkRootDomain cfg.url);
    server.web-servers.nginx.proxies = lib.mkIf config.server.web-servers.nginx.enable (singleton {
      source = cfg.url;
      target = "http://${config.system.hostname}:${builtins.toString cfg.port}";
    });
    services.librechat = {
      enable = true;
      openFirewall = true;
      inherit (cfg) port;
      env = {
        HOST = "0.0.0.0";
        ALLOW_REGISTRATION = "true";
        NO_INDEX = "true";
        MONGO_URI = cfg.mongodbURI;
        DOMAIN_CLIENT = cfg.url;
        DOMAIN_SERVER = cfg.url;
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

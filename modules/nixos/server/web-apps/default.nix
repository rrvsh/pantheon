{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.server.web-apps;
in
{

  imports = [
    "${inputs.rrvsh-nixpkgs}/nixos/modules/services/web-apps/librechat.nix"
  ];

  options.server.web-apps = {
    librechat.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf cfg.librechat.enable {
    services.librechat = {
      enable = true;
      openFirewall = true;
      port = 3080;
      env = {
        HOST = "0.0.0.0";
        ALLOW_REGISTRATION = "true";
        MONGO_URI = "mongodb://apollo:27017";
      };
      credentials = {
        CREDS_KEY = config.sops.secrets."librechat/creds_key".path;
        CREDS_IV = config.sops.secrets."librechat/creds_iv".path;
        JWT_SECRET = config.sops.secrets."librechat/jwt_secret".path;
        JWT_REFRESH_SECRET = config.sops.secrets."librechat/jwt_refresh_secret".path;
      };
      settings = {
        version = "1.0.8";
        cache = true;
        interface = {
          privacyPolicy = {
            externalUrl = "https://librechat.ai/privacy-policy";
            openNewTab = true;
          };
        };
        endpoints = {
          custom = [
            {
              name = "OpenRouter";
              apiKey = "\${OPENROUTER_KEY}";
              baseURL = "https://openrouter.ai/api/v1";
              models = {
                default = [ "meta-llama/llama-3-70b-instruct" ];
                fetch = true;
              };
              titleConvo = true;
              titleModule = "meta-llama/llama-3-70b-instruct";
              dropParams = [ "stop" ];
              modelDisplayLabel = "OpenRouter";
            }
          ];
        };
      };
    };
  };
}

{ config, lib, ... }:
let
  inherit (lib) mkIf mkOption mkEnableOption;
  inherit (lib.types) enum str listOf;
  inherit (lib.lists) unique;
  inherit (builtins) map;
  cfg = config.server.networking.ddns;
  mkDomain = domain_name: {
    inherit domain_name;
    sub_domains = [
      "@"
      "*"
    ];
  };
  # Sanitize the list of domains with unique so we can add to it with every service.
  mkDomains = map mkDomain (unique cfg.domains);
in
{
  options.server.networking.ddns = {
    enable = mkEnableOption "";
    type = mkOption {
      type = enum [ "godns" ];
      default = "godns";
    };
    domains = mkOption {
      type = listOf str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    services.godns = {
      enable = if (cfg.type == "godns") then true else false;
      loadCredential = [
        "cf_token:${config.sops.secrets."keys/cloudflare".path}"
        "telegram_bot_token:${config.sops.secrets."keys/telegram_bot".path}"
      ];
      settings = {
        provider = "Cloudflare";
        login_token_file = "$CREDENTIALS_DIRECTORY/cf_token";
        domains = mkDomains;
        resolver = "1.1.1.1";
        ip_urls = [
          "https://wtfismyip.com/text"
          "https://api.ipify.org"
          "https://myip.biturl.top"
          "https://api-ipv4.ip.sb/ip"
        ];
        ip_type = "IPv4";
        interval = 300;
        notify = {
          telegram = {
            enabled = true;
            bot_api_key_file = "$CREDENTIALS_DIRECTORY/telegram_bot_token";
            chat_id = "384288005";
            message_template = "Domain *{{ .Domain  }} has been updated to %0A{{ .CurrentIP }}";
          };
        };
      };
    };
  };
}

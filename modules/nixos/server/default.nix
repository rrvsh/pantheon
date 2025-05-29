{ lib, config, ... }:
{
  options.server = {
    enableDDNS = lib.mkEnableOption "";
  };

  config = lib.mkMerge [
    (lib.mkIf config.server.enableDDNS {
      services.godns = {
        enable = true;
        loadCredential = [
          "cf_token:${config.sops.secrets."keys/cloudflare".path}"
          "telegram_bot_token:${config.sops.secrets."keys/telegram_bot".path}"
        ];
        settings = {
          provider = "Cloudflare";
          login_token_file = "$CREDENTIALS_DIRECTORY/cf_token";
          domains = [
            {
              domain_name = "rrv.sh";
              sub_domains = [ "@" ];
            }
            {
              domain_name = "aenyrathia.wiki";
              sub_domains = [ "@" ];
            }
            {
              domain_name = "bwfiq.com";
              sub_domains = [ "*" ];
            }
            {
              domain_name = "slayment.com";
              sub_domains = [ "*" ];
            }
          ];
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
    })
  ];
}

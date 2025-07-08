{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum str listOf;
  inherit (lib.lists) unique;
  inherit (builtins) map;
  inherit (config.flake.paths) secrets;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    let
      cfg = config.server.ddns;
      mkDomain = domain_name: {
        inherit domain_name;
        sub_domains = [
          "@"
          "*"
        ];
      };
    in
    {
      options.server.ddns = {
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
        sops.secrets."keys/cloudflare".sopsFile = secrets + "/keys.yaml";
        services.godns = {
          enable = if (cfg.type == "godns") then true else false;
          loadCredential = [ "cf_token:${config.sops.secrets."keys/cloudflare".path}" ];
          settings = {
            provider = "Cloudflare";
            login_token_file = "$CREDENTIALS_DIRECTORY/cf_token";
            # Sanitize the list of domains with unique so we can add to it with every service.
            domains = map mkDomain (unique cfg.domains);
            resolver = "1.1.1.1";
            ip_urls = [
              "https://wtfismyip.com/text"
              "https://api.ipify.org"
              "https://myip.biturl.top"
              "https://api-ipv4.ip.sb/ip"
            ];
            ip_type = "IPv4";
            interval = 300;
          };
        };
      };
    };
}

{ config, ... }:
{
  config = {
    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "rafiq@rrv.sh";
        dnsProvider = "cloudflare";
        credentialFiles = {
          "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.sops.secrets."keys/cloudflare".path;
        };
      };
    };
  };
}

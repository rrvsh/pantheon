{ config, lib, ... }:
let
  inherit (lib)
    mkMerge
    mkIf
    mkEnableOption
    singleton
    ;
  cfg = config.server.web-servers;
in
{
  options.server.web-servers = {
    enableSSL = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf cfg.enableSSL {
      security.acme = {
        acceptTerms = true;
        defaults = {
          inherit (config.system.mainUser) email;
          dnsProvider = "cloudflare";
          credentialFiles."CLOUDFLARE_DNS_API_TOKEN_FILE" = config.sops.secrets."keys/cloudflare".path;
        };
        certs = {
          "rrv.sh".extraDomainNames = singleton "*.rrv.sh";
          "bwfiq.com".extraDomainNames = singleton "*.bwfiq.com";
          "slayment.com".extraDomainNames = singleton "*.slayment.com";
          "aenyrathia.wiki".extraDomainNames = singleton "*.aenyrathia.wiki";
        };
      };
    })
  ];
}

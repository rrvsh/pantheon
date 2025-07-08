{ lib, config, ... }:
let
  inherit (builtins) listToAttrs map;
  inherit (config.flake.lib.options) mkStrOption mkPathOption;
  inherit (config.flake.lib.services) mkRootDomain;
  inherit (config.flake.paths) secrets;
  inherit (config.flake.admin) email;
  inherit (lib.types) listOf submodule attrs;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.modules) mkMerge mkIf;
  inherit (lib.lists) singleton;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    let
      cfg = config.server.web-servers;
    in
    {
      options.server.web-servers = {
        enableSSL = mkEnableOption "";
      };
      config = mkMerge [
        (mkIf cfg.enableSSL {
          sops.secrets."keys/cloudflare".sopsFile = secrets + "/keys.yaml";
          security.acme = {
            acceptTerms = true;
            defaults = {
              inherit email;
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
    };
}

{ lib, config, ... }:
let
  inherit (builtins) listToAttrs map;
  inherit (config.flake.lib.options) mkStrOption mkPathOption;
  inherit (config.flake.lib.services) mkRootDomain;
  inherit (config.flake.paths) secrets;
  inherit (config.manifest.admin) email;
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
      sslCheck = good: bad: if cfg.enableSSL then good else bad;
    in
    {
      options.server.web-servers = {
        enableSSL = mkEnableOption "";
        nginx = {
          enable = mkEnableOption "the Nginx server";
          openFirewall = mkEnableOption "" // {
            default = true;
          };
          enableDefaultSink = mkEnableOption "" // {
            default = true;
          };
          pages = mkOption {
            default = [ ];
            type = listOf (submodule {
              options = {
                domain = mkStrOption "";
                root = mkPathOption "";
                extraConfig = mkOption {
                  type = attrs;
                  default = { };
                };
                locations = mkOption {
                  type = attrs;
                  default = { };
                };
              };
            });
          };
          proxies = mkOption {
            default = [ ];
            type = listOf (submodule {
              options = {
                source = mkStrOption "";
                target = mkStrOption "";
                extraConfig = mkOption {
                  type = attrs;
                  default = { };
                };
                locations = mkOption {
                  type = attrs;
                  default = { };
                };
              };
            });
          };
        };
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
        (mkIf cfg.nginx.enable {
          networking.firewall.allowedTCPPorts = mkIf cfg.nginx.openFirewall [
            443
            80
          ];
          users.users.nginx.extraGroups = singleton "acme";
          services.nginx = {
            enable = true;
            recommendedProxySettings = true;
            recommendedTlsSettings = true;
            recommendedOptimisation = true;
            recommendedGzipSettings = true;
            virtualHosts = mkMerge [
              (mkIf cfg.nginx.enableDefaultSink {
                "_" = {
                  default = true;
                  rejectSSL = sslCheck true false;
                  locations."/" = {
                    return = "444";
                  };
                };
              })
              (listToAttrs (
                map (page: {
                  name = page.domain;
                  value = {
                    addSSL = sslCheck true false;
                    useACMEHost = sslCheck (mkRootDomain page.domain) null;
                    acmeRoot = null; # needed for DNS validation
                    locations = {
                      "/" = {
                        inherit (page) root;
                      } // page.extraConfig;
                    } // page.locations;
                  };
                }) cfg.nginx.pages
              ))
              (listToAttrs (
                map (proxy: {
                  name = proxy.source;
                  value = {
                    addSSL = sslCheck true false;
                    useACMEHost = sslCheck (mkRootDomain proxy.source) null;
                    acmeRoot = null; # needed for DNS validation
                    locations = {
                      "/" = {
                        proxyPass = proxy.target;
                      } // proxy.extraConfig;
                    } // proxy.locations;
                  };
                }) cfg.nginx.proxies
              ))
            ];
          };
        })
      ];
    };
}

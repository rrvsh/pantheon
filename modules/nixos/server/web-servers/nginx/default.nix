{ config, lib, ... }:
let
  inherit (lib)
    mkMerge
    mkOption
    mkEnableOption
    mkIf
    singleton
    ;
  inherit (lib.types) listOf submodule attrs;
  inherit (lib.pantheon) mkStrOption mkRootDomain;
  inherit (builtins) listToAttrs map;
  cfg = config.server.web-servers.nginx;
  sslCheck = good: bad: if config.server.web-servers.enableSSL then good else bad;
  defaultSink = mkIf cfg.enableDefaultSink {
    "_" = {
      default = true;
      rejectSSL = sslCheck true false;
      locations."/" = {
        return = "444";
      };
    };
  };
  proxyPasses = listToAttrs (
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
    }) cfg.proxies
  );
in
{
  options.server.web-servers.nginx = {
    enable = mkEnableOption "the Nginx server";
    openFirewall = mkEnableOption "" // {
      default = true;
    };
    enableDefaultSink = mkEnableOption "" // {
      default = true;
    };
    proxies = mkOption {
      default = [ ];
      type = listOf (submodule {
        options = {
          source = mkStrOption;
          target = mkStrOption;
          extraConfig = lib.mkOption {
            type = attrs;
            default = { };
          };
          locations = lib.mkOption {
            type = attrs;
            default = { };
          };
        };
      });
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      443
      80
    ];
    users.users.nginx.extraGroups = singleton "acme";
    services.nginx = {
      enable = true;
      virtualHosts = mkMerge [
        defaultSink
        proxyPasses
      ];
    };
  };
}

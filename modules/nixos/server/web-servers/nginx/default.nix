{ config, lib, ... }:
let
  inherit (lib)
    mkMerge
    mkOption
    mkEnableOption
    mkIf
    ;
  inherit (lib.pantheon) mkStrOption;
  inherit (builtins) listToAttrs map;
  cfg = config.server.web-servers.nginx;
  sslCheck = if config.server.web-servers.enableSSL then true else false;
  defaultSink = mkIf cfg.enableDefaultSink {
    "_" = {
      default = true;
      rejectSSL = sslCheck;
      locations."/" = {
        return = "444";
      };
    };
  };
  proxyPasses = listToAttrs (
    map (proxy: {
      name = proxy.source;
      value = {
        addSSL = sslCheck;
        enableACME = sslCheck;
        acmeRoot = null;
        locations."/" = {
          proxyPass = proxy.target;
        } // proxy.extraConfig;
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
      type =
        with lib.types;
        listOf (submodule {
          options = {
            source = mkStrOption;
            target = mkStrOption;
            extraConfig = lib.mkOption {
              type = attrs;
              default = { };
              description = "Will be added to locations.\"/\"";
            };
          };
        });
      default = [ ];
      example = [
        {
          source = "chat.bwfiq.com";
          target = "http://helios:3080";
          extraConfig = { };
        }
      ];
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      443
      80
    ];
    services.nginx = {
      enable = true;
      virtualHosts = mkMerge [
        defaultSink
        proxyPasses
      ];
    };
  };
}

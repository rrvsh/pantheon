{ config, lib, ... }:
let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.pantheon) mkStrOption;
  inherit (builtins) listToAttrs map;
  inherit (config.server.web-servers) enableSSL;
  cfg = config.server.web-servers.nginx;
  defaultSink = mkIf cfg.enableDefaultSink {
    "_" = {
      default = true;
      rejectSSL = mkIf enableSSL true;
      locations."/" = {
        return = "444";
      };
    };
  };
  proxyPasses = listToAttrs (
    map (proxy: {
      name = proxy.source;
      value = {
        forceSSL = mkIf enableSSL true;
        enableACME = mkIf enableSSL true;
        acmeRoot = mkIf enableSSL null;
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
      virtualHosts = defaultSink // proxyPasses;
    };
  };
}

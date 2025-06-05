{ config, lib, ... }:
let
  cfg = config.server.web-servers;
in
{
  options.server.web-servers = {
    nginx = {
      enable = lib.mkEnableOption "the Nginx server";
      proxies = lib.mkOption {
        type =
          with lib.types;
          listOf (submodule {
            options = {
              source = lib.pantheon.mkStrOption;
              target = lib.pantheon.mkStrOption;
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
  };
  config = lib.mkMerge [
    {
      security.acme = {
        acceptTerms = true;
        defaults.email = "rafiq@rrv.sh";
      };
    }
    (lib.mkIf cfg.nginx.enable {
      networking.firewall.allowedTCPPorts = [
        443
        80
      ];
      services.nginx = {
        enable = true;
        virtualHosts = builtins.listToAttrs (
          builtins.map (proxy: {
            name = proxy.source;
            value = {
              forceSSL = true;
              enableACME = true;
              locations."/" = {
                proxyPass = proxy.target;
              } // proxy.extraConfig;
            };
          }) cfg.nginx.proxies
        );
      };
    })
  ];
}

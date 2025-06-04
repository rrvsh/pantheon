{ config, lib, ... }:
let
  cfg = config.server.web-servers;
in
{
  options.server.web-servers = {
    nginx = {
      enable = lib.mkEnableOption "the Nginx server";
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
        virtualHosts = {
          "chat.bwfiq.com" = {
            forceSSL = true;
            enableACME = true;
            locations."/" = {
              proxyPass = "http://helios:3080";
            };
          };
          "il.bwfiq.com" = {
            forceSSL = true;
            enableACME = true;
            locations."/" = {
              proxyPass = "http://helios:2283";
            };
          };
          ${config.system.hostname} = {
            locations."/" = {
              return = "200 '<html><body>It works!</body></html'";
              extraConfig = ''
                default_type text/html;
              '';
            };
          };
        };
      };
    })
  ];
}

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
    (lib.mkIf cfg.nginx.enable {
      networking.firewall.allowedTCPPorts = [ 80 ];
      services.nginx = {
        enable = true;
        virtualHosts.${config.system.hostname} = {
          locations."/" = {
            return = "200 '<html><body>It works!</body></html'";
            extraConfig = ''
              default_type text/html;
            '';
          };
        };
      };
    })
  ];
}

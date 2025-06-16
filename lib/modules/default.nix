{ lib, ... }:
let
  inherit (builtins) toString;
  inherit (lib)
    mkMerge
    mkEnableOption
    singleton
    mkIf
    ;
  inherit (lib.pantheon)
    mkAttrOption
    mkRootDomain
    mkPortOption
    mkStrOption
    ;
  networkingConfig =
    {
      config,
      cfg,
      name,
    }:
    mkIf (cfg.domain != "") {
      assertions = singleton {
        assertion = config.server.web-servers.nginx.enable;
        message = "You must enable a web server if you want to set server.web-apps.${name}.domain.";
      };
      server.networking.ddns.domains = singleton (mkRootDomain cfg.domain);
      server.web-servers.nginx.proxies = singleton {
        source = cfg.domain;
        target = "http://${config.hostname}:${toString cfg.port}";
      };
    };
in
{
  modules.mkWebApp =
    {
      config,
      name,
      defaultPort,
      persistDirs ? [ ],
      extraOptions ? { },
      extraConfig ? { },
    }:
    let
      cfg = config.server.web-apps.${name};
    in
    {
      options.server.web-apps.${name} = {
        enable = mkEnableOption "";
        port = mkPortOption defaultPort;
        domain = mkStrOption;
        openFirewall = mkEnableOption "";
        extraCfg = mkAttrOption;
      } // extraOptions;

      config = mkIf cfg.enable (mkMerge [
        {
          inherit persistDirs;
          networking.firewall = mkIf cfg.openFirewall { allowedTCPPorts = singleton cfg.port; };
        }
        (networkingConfig { inherit config cfg name; })
        extraConfig
      ]);
    };
}

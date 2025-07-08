{ config, lib, ... }:
let
  inherit (builtins) length concatStringsSep;
  inherit (lib.options) mkEnableOption;
  inherit (lib.strings) splitString;
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkMerge mkIf;
  inherit (cfg.lib.options) mkStrOption mkPortOption mkAttrOption;
  inherit (cfg.lib.lists) shortenList;
  cfg = config.flake;
in
{
  flake.lib.services = rec {
    splitDomain = domain: splitString "." domain;
    isRootDomain = domain: length (splitDomain domain) <= 2;
    mkRootDomain = domain: concatStringsSep "." (shortenList 2 (splitDomain domain));
    mkWildcardDomain = rootDomain: concatStringsSep "." ((singleton "*") ++ (splitDomain rootDomain));
    mkHost = domain: if isRootDomain domain then domain else mkWildcardDomain (mkRootDomain domain);
    mkWebApp =
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
            server.ddns.domains = singleton (mkRootDomain cfg.domain);
            server.web-servers.nginx.proxies = singleton {
              source = cfg.domain;
              target = "http://${config.hostname}:${toString cfg.port}";
            };
          };

      in
      {
        options.server.web-apps.${name} = {
          enable = mkEnableOption "";
          port = mkPortOption defaultPort;
          domain = mkStrOption "";
          openFirewall = mkEnableOption "";
          extraCfg = mkAttrOption { };
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

  };
}

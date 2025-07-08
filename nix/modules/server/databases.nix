{ lib, config, ... }:
let
  inherit (builtins) toString;
  inherit (lib.modules) mkIf mkMerge mkOverride;
  inherit (lib.lists) singleton;
  inherit (lib.options) mkEnableOption;
  inherit (config.flake.lib.options) mkPortOption;
in
{
  allowedUnfreePackages = [ "mongodb" ];
  flake.modules.nixos.default =
    { config, pkgs, ... }:
    let
      cfg = config.server.databases;
    in
    {
      options.server.databases = {
        mongodb = {
          enable = mkEnableOption "the MongoDB server";
          port = mkPortOption 27017;
        };
        mysql = {
          enable = mkEnableOption "the MySQL server";
          port = mkPortOption 3306;
        };
        postgresql = {
          enable = mkEnableOption "the postgresql server";
          port = mkPortOption 5432;
        };
      };

      config = mkMerge [
        (mkIf cfg.postgresql.enable {
          networking.firewall.allowedTCPPorts = singleton cfg.postgresql.port;
          persistDirs = singleton {
            directory = toString config.services.postgresql.dataDir;
            user = "postgres";
            group = "postgres";
          };
          services.postgresql = {
            enable = true;
            enableTCPIP = true;
            settings = { inherit (cfg.postgresql) port; };
            authentication = mkOverride 10 ''
              #type database DBuser auth-method
              local all all trust

              # ipv4
              host all all 0.0.0.0/0 trust
            '';
            ensureDatabases = singleton "alphastory";
            ensureUsers = singleton {
              name = "alphastory";
              ensureDBOwnership = true;
            };
          };
        })
        (mkIf cfg.mongodb.enable {
          networking.firewall.allowedTCPPorts = [ cfg.mongodb.port ];
          persistDirs = singleton {
            directory = toString config.services.mongodb.dbpath;
            user = "mongodb";
            group = "mongodb";
          };
          services.mongodb = {
            enable = true;
            bind_ip = "0.0.0.0";
            extraConfig = ''
              net.port: ${toString cfg.mongodb.port}
            '';
          };
        })
        (mkIf cfg.mysql.enable {
          networking.firewall.allowedTCPPorts = [ cfg.mysql.port ];
          persistDirs = singleton {
            directory = toString config.services.mysql.dataDir;
            user = "mysql";
            group = "mysql";
          };
          services.mysql = {
            enable = true;
            package = pkgs.mariadb;
            settings.mysqld = {
              inherit (cfg.mysql) port;
            };
          };
        })
      ];
    };
}

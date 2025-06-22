{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) singleton;
  cfg = config.server.databases;
in
{
  options.server.databases = {
    mongodb = {
      enable = lib.mkEnableOption "the MongoDB server";
      port = lib.pantheon.mkPortOption 27017;
    };
    mysql = {
      enable = lib.mkEnableOption "the MySQL server";
      port = lib.pantheon.mkPortOption 3306;
    };
    postgresql = {
      enable = lib.mkEnableOption "the postgresql server";
      port = lib.pantheon.mkPortOption 5432;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.postgresql.enable {
      networking.firewall.allowedTCPPorts = lib.singleton cfg.postgresql.port;
      persistDirs = singleton {
        directory = builtins.toString config.services.postgresql.dataDir;
        user = "postgres";
        group = "postgres";
      };
      services.postgresql = {
        enable = true;
        enableTCPIP = true;
        settings = { inherit (cfg.postgresql) port; };
        authentication = lib.mkOverride 10 ''
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
    (lib.mkIf cfg.mongodb.enable {
      networking.firewall.allowedTCPPorts = [ cfg.mongodb.port ];
      persistDirs = singleton {
        directory = builtins.toString config.services.mongodb.dbpath;
        user = "mongodb";
        group = "mongodb";
      };
      services.mongodb = {
        enable = true;
        bind_ip = "0.0.0.0";
        extraConfig = ''
          net.port: ${builtins.toString cfg.mongodb.port}
        '';
      };
    })
    (lib.mkIf cfg.mysql.enable {
      networking.firewall.allowedTCPPorts = [ cfg.mysql.port ];
      persistDirs = singleton {
        directory = builtins.toString config.services.mysql.dataDir;
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
}

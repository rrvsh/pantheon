{
  lib,
  config,
  pkgs,
  ...
}:
let
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
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.mongodb.enable {
      networking.firewall.allowedTCPPorts = [ cfg.mongodb.port ];
      environment.persistence."/persist".directories = [
        {
          directory = builtins.toString config.services.mongodb.dbpath;
          user = "mongodb";
          group = "mongodb";
        }
      ];
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
      environment.persistence."/persist".directories = [
        {
          directory = builtins.toString config.services.mysql.dataDir;
          user = "mysql";
          group = "mysql";
        }
      ];
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

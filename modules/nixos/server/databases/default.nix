{ lib, config, ... }:
let
  cfg = config.server.databases;
in
{
  options.server.databases = {
    mongodb.enable = lib.mkEnableOption "";
    mongodb.dbPath = lib.mkOption {
      type = lib.types.str;
      default = "/var/db/mongodb";
    };
    mongodb.port = lib.mkOption {
      type = lib.types.int;
      default = 27017;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.mongodb.enable {
      environment.persistence."/persist".directories = [
        {
          directory = cfg.mongodb.dbPath;
          user = "mongodb";
          group = "mongodb";
        }
      ];
      networking.firewall.allowedTCPPorts = [ cfg.mongodb.port ];
      services.mongodb = {
        enable = true;
        dbpath = cfg.mongodb.dbPath;
        bind_ip = "0.0.0.0";
        extraConfig = ''
          net.port: ${builtins.toString cfg.mongodb.port}
        '';
      };
    })
  ];
}

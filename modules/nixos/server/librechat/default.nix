#TODO: add settings option that generates librechat.yaml
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.server.librechat;
in
{
  options.server.librechat = {
    enable = lib.mkEnableOption "Whether to enable the LibreChat server.";
    openFirewall = lib.mkEnableOption "Whether to open the port in the firewall.";

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      example = # nix
        ''
          {

          }
        '';
      description = "A free-form attribute set that will be written to librechat.yaml.";
    };

    path = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/librechat";
      description = "Absolute path for where the LibreChat server will use as its working directory.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "librechat";
      description = "The user to run the service as.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "librechat";
      description = "The group to run the service as.";
    };

    prevent-indexing = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Prevents public search engines from indexing your website.";
    };

    host = lib.mkOption {
      type = lib.types.str;
      default = "localhost";
      example = "0.0.0.0";
      description = "Specifies the host.";
    };

    port = lib.mkOption {
      type = lib.types.int;
      default = 3080;
      example = 2309;
      description = "Specifies the port.";
    };

    #TODO: Add option to use documentDb.
    mongodbURI = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "mongodb://127.0.0.1:27017/LibreChat";
      description = "Specifies the MongoDB URI. Must be set or the app will crash on startup.";
    };

    trust_proxy = lib.mkOption {
      type = lib.types.int;
      default = 1;
      example = 0;
      description = "Use the address that is at most n number of hops away from the Express application. See https://expressjs.com/en/guide/behind-proxies.html for more information about this.";
    };

    credentials = {
      creds_key = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "32-byte key (64 characters in hex) for securely storing credentials. Required for app startup. WARNING: If you don't set this or the _file option, the app will crash on startup. You can use this https://www.librechat.ai/toolkit/creds_generator to generate them quickly.";
      };
      creds_key_file = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Path to file containing 32-byte key (64 characters in hex) for securely storing credentials. Required for app startup. WARNING: If you don't set this or the _file option, the app will crash on startup. You can use this https://www.librechat.ai/toolkit/creds_generator to generate them quickly.";
      };
      creds_iv = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "16-byte IV (32 characters in hex) for securely storing credentials. Required for app startup. WARNING: If you don't set this or the _file option, the app will crash on startup. You can use this https://www.librechat.ai/toolkit/creds_generator to generate them quickly.";
      };
      creds_iv_file = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Path to file containing 16-byte IV (32 characters in hex) for securely storing credentials. Required for app startup. WARNING: If you don't set this or the _file option, the app will crash on startup. You can use this https://www.librechat.ai/toolkit/creds_generator to generate them quickly.";
      };
      jwt_secret = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "JWT secret key. Generate with https://www.librechat.ai/toolkit/creds_generator.";
      };
      jwt_secret_file = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Absolute path to file containing JWT secret key. Generate with https://www.librechat.ai/toolkit/creds_generator.";
      };
      jwt_refresh_secret = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "JWT refresh secret key. Generate with https://www.librechat.ai/toolkit/creds_generator.";
      };
      jwt_refresh_secret_file = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Absolute path to file containing JWT refresh secret key. Generate with https://www.librechat.ai/toolkit/creds_generator.";
      };
    };

    app_domains = {
      client = lib.mkOption {
        type = lib.types.str;
        default = "http://localhost:${cfg.port}";
        example = "https://librechat.example.com";
        description = "Specifies the client-side domain.";
      };
      server = lib.mkOption {
        type = lib.types.str;
        default = "http://localhost:${cfg.port}";
        example = "https://librechat.example.com";
        description = "Specifies the server-side domain.";
      };
    };

    logging = {
      enableDebugLogging = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Keep debug logs active.";
      };
      enableConsoleLogging = lib.mkEnableOption "Enable verbose console/stdout logs in the same format as file debug logs.";
      enableConsoleJSONLogging = lib.mkEnableOption "Enable verbose JSON console/stdout logs suitable for cloud deployments like GCP/AWS.";
      consoleJSONLoggingLength = lib.mkOption {
        type = lib.types.int;
        default = 255;
        description = "Configure the truncation size for console/stdout logs.";
      };
    };

    static_cache = {
      max_age = lib.mkOption {
        type = lib.types.str;
        default = "172800";
        description = "Cache-Control max-age in seconds.";
      };
      s_max_age = lib.mkOption {
        type = lib.types.str;
        default = "86400";
        description = "Cache-Control s-maxage in seconds for shared caches (CDNs and proxies).";
      };
      disable_compression = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Disables compression for static files.";
      };
    };

    index_page_caching = {
      cache_control = lib.mkOption {
        type = lib.types.str;
        default = "no-cache, no-store, must-revalidate";
        description = "Cache-Control header for index.html.";
      };
      pragma = lib.mkOption {
        type = lib.types.str;
        default = "no-cache";
        description = "Pragma header for index.html.";
      };
      expires = lib.mkOption {
        type = lib.types.str;
        default = "0";
        description = "Expires header for index.html.";
      };
    };

    auth = {
      allowEmailLogin = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable or disable ONLY email login.";
      };
      allowEmailRegistration = lib.mkEnableOption "Enable or disable Email registration of new users.";
    };

  };

  config = lib.mkIf cfg.enable (
    let
      configFile = pkgs.writeTextFile {
        name = "librechat.yaml";
        text = lib.generators.toYAML { } cfg.settings;
      };
    in
    {

      assertions = [
        {
          assertion = (cfg.credentials.creds_key != "") || (cfg.credentials.creds_key_file != "");
          message = "You must set either credentials.creds_key or credentials.creds_key_file.";
        }
        {
          assertion = (cfg.credentials.creds_iv != "") || (cfg.credentials.creds_iv_file != "");
          message = "You must set either credentials.creds_iv or credentials.creds_iv_file.";
        }
        {
          assertion = cfg.mongodbURI != "";
          message = "You must set the mongodbURI option.";
        }
        {
          assertion =
            cfg.logging.enableDebugLogging
            && (
              (cfg.logging.enableConsoleLogging && !cfg.logging.enableConsoleJSONLogging)
              || (!cfg.logging.enableConsoleLogging && cfg.logging.enableConsoleJSONLogging)
              || (!cfg.logging.enableConsoleLogging && !cfg.logging.enableConsoleJSONLogging)
            );
          message = "DEBUG_LOGGING can be used with either DEBUG_CONSOLE or CONSOLE_JSON but not both.";
        }
        {
          assertion = (cfg.credentials.jwt_secret != "") || (cfg.credentials.jwt_secret_file != "");
          message = "You must set either credentials.jwt_secret or credentials.jwt_secret_file.";
        }
        {
          assertion =
            (cfg.credentials.jwt_refresh_secret != "") || (cfg.credentials.jwt_refresh_secret_file != "");
          message = "You must set either credentials.jwt_refresh_secret or credentials.jwt_refresh_secret_file.";
        }
      ];

      networking.firewall.allowedTCPPorts = if cfg.openFirewall then [ cfg.port ] else [ ];
      systemd.services.librechat = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        description = "Open-source app for all your AI conversations, fully customizable and compatible with any AI provider";
        serviceConfig = {
          Type = "simple"; # FIXME
          User = cfg.user;
          Group = cfg.group;
          PermissionsStartOnly = "true"; # run mkdir as root
          ExecStartPre = [
            "${pkgs.coreutils}/bin/mkdir -p ${cfg.path}"
            "${pkgs.coreutils}/bin/chown -R ${cfg.user}:${cfg.group} ${cfg.path}"
          ];
          LoadCredential = [
            #TODO: Use the creds_* options
            "CREDS_KEY_FILE:${cfg.credentials.creds_key_file}"
            "CREDS_IV_FILE:${cfg.credentials.creds_iv_file}"
            "JWT_SECRET_FILE:${cfg.credentials.jwt_secret_file}"
            "JWT_REFRESH_SECRET_FILE:${cfg.credentials.jwt_refresh_secret_file}"
          ];
        };
        script = # sh
          ''
            # Load the systemd credentials
            export CREDS_KEY=$(${pkgs.systemd}/bin/systemd-creds cat CREDS_KEY_FILE)
            export CREDS_IV=$(${pkgs.systemd}/bin/systemd-creds cat CREDS_IV_FILE)
            export JWT_SECRET=$(${pkgs.systemd}/bin/systemd-creds cat JWT_SECRET_FILE)
            export JWT_REFRESH_SECRET=$(${pkgs.systemd}/bin/systemd-creds cat JWT_REFRESH_SECRET_FILE)

            export CONFIG_PATH=${configFile}
            export HOST=${cfg.host}
            export PORT=${builtins.toString cfg.port}
            export MONGO_URI="${cfg.mongodbURI}"
            export ALLOW_EMAIL_LOGIN=${if cfg.auth.allowEmailLogin then "true" else "false"}
            export ALLOW_REGISTRATION=${if cfg.auth.allowEmailRegistration then "true" else "false"}

            cd ${cfg.path}
            ${pkgs.librechat}/bin/librechat-server
          '';
      };

      users.users.librechat = lib.mkIf (cfg.user == "librechat") {
        name = "librechat";
        isSystemUser = true;
        group = "librechat";
        description = "LibreChat server user";
      };
      users.groups.librechat = lib.mkIf (cfg.user == "librechat") { };
    }
  );
}

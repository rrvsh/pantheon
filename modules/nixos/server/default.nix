{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.server = {
    mountHelios = lib.mkEnableOption "";
    enableDDNS = lib.mkEnableOption "";
    librechat = {
      enable = lib.mkEnableOption "";
      mongodbURI = lib.mkOption { type = lib.types.str; };
      creds_key_file = lib.mkOption { type = lib.types.str; };
      creds_iv_file = lib.mkOption { type = lib.types.str; };
      jwt_secret_file = lib.mkOption { type = lib.types.str; };
      jwt_refresh_secret_file = lib.mkOption { type = lib.types.str; };
      meili_master_key_file = lib.mkOption { type = lib.types.str; };
      path = lib.mkOption {
        type = lib.types.str;
        default = "/var/lib/librechat";
      };
      user = lib.mkOption {
        type = lib.types.str;
        default = "librechat";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.server.librechat.enable {
      environment.persistence."/persist".directories = [
        {
          directory = config.server.librechat.path;
          user = config.server.librechat.user;
          group = "librechat";
        }
      ];
      systemd.services.librechat = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        description = "Open-source app for all your AI conversations, fully customizable and compatible with any AI provider";
        serviceConfig = {
          Type = "simple"; # FIXME
          User = config.server.librechat.user;
          LoadCredential = [
            "CREDS_KEY_FILE:${config.server.librechat.creds_key_file}"
            "CREDS_IV_FILE:${config.server.librechat.creds_iv_file}"
            "JWT_SECRET_FILE:${config.server.librechat.jwt_secret_file}"
            "JWT_REFRESH_SECRET_FILE:${config.server.librechat.jwt_refresh_secret_file}"
            "MEILI_MASTER_KEY_FILE:${config.server.librechat.meili_master_key_file}"
          ];
        };
        script = # sh
          ''
            export MONGO_URI="${config.server.librechat.mongodbURI}"
            export CREDS_KEY=$(${pkgs.systemd}/bin/systemd-creds cat CREDS_KEY_FILE)
            export CREDS_IV=$(${pkgs.systemd}/bin/systemd-creds cat CREDS_IV_FILE)
            export JWT_SECRET=$(${pkgs.systemd}/bin/systemd-creds cat JWT_SECRET_FILE)
            export JWT_REFRESH_SECRET=$(${pkgs.systemd}/bin/systemd-creds cat JWT_REFRESH_SECRET_FILE)
            export MEILI_MASTER_KEY=$(${pkgs.systemd}/bin/systemd-creds cat MEILI_MASTER_KEY_FILE)
            cd ${config.server.librechat.path}
            ${pkgs.librechat}/bin/librechat-server
          '';
      };

      users.users.librechat = lib.mkIf (config.server.librechat.user == "librechat") {
        name = "librechat";
        isSystemUser = true;
        group = "librechat";
        description = "LibreChat server user";
      };
      users.groups.librechat = lib.mkIf (config.server.librechat.user == "librechat") { };
    })
    (lib.mkIf config.server.enableDDNS {
      services.godns = {
        enable = true;
        loadCredential = [
          "cf_token:${config.sops.secrets."keys/cloudflare".path}"
          "telegram_bot_token:${config.sops.secrets."keys/telegram_bot".path}"
        ];
        settings = {
          provider = "Cloudflare";
          login_token_file = "$CREDENTIALS_DIRECTORY/cf_token";
          domains = [
            {
              domain_name = "rrv.sh";
              sub_domains = [ "@" ];
            }
            {
              domain_name = "aenyrathia.wiki";
              sub_domains = [ "@" ];
            }
            {
              domain_name = "bwfiq.com";
              sub_domains = [ "*" ];
            }
            {
              domain_name = "slayment.com";
              sub_domains = [ "*" ];
            }
          ];
          resolver = "1.1.1.1";
          ip_urls = [
            "https://wtfismyip.com/text"
            "https://api.ipify.org"
            "https://myip.biturl.top"
            "https://api-ipv4.ip.sb/ip"
          ];
          ip_type = "IPv4";
          interval = 300;
          notify = {
            telegram = {
              enabled = true;
              bot_api_key_file = "$CREDENTIALS_DIRECTORY/telegram_bot_token";
              chat_id = "384288005";
              message_template = "Domain *{{ .Domain  }} has been updated to %0A{{ .CurrentIP }}";
            };
          };
        };
      };
    })
    (lib.mkIf config.server.mountHelios {
      fileSystems."/media/helios/data" = {
        device = "//helios/data";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "x-systemd.requires=tailscaled.service"
          "x-systemd.mount-timeout=0"
        ];
      };
    })
  ];
}

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

  config = lib.mkIf cfg.enable {
    systemd.services.librechat = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "Open-source app for all your AI conversations, fully customizable and compatible with any AI provider";
      serviceConfig = {
        Type = "simple"; # FIXME
        User = cfg.user;
        LoadCredential = [
          "CREDS_KEY_FILE:${cfg.creds_key_file}"
          "CREDS_IV_FILE:${cfg.creds_iv_file}"
          "JWT_SECRET_FILE:${cfg.jwt_secret_file}"
          "JWT_REFRESH_SECRET_FILE:${cfg.jwt_refresh_secret_file}"
          "MEILI_MASTER_KEY_FILE:${cfg.meili_master_key_file}"
        ];
      };
      script = # sh
        ''
          export MONGO_URI="${cfg.mongodbURI}"
          export CREDS_KEY=$(${pkgs.systemd}/bin/systemd-creds cat CREDS_KEY_FILE)
          export CREDS_IV=$(${pkgs.systemd}/bin/systemd-creds cat CREDS_IV_FILE)
          export JWT_SECRET=$(${pkgs.systemd}/bin/systemd-creds cat JWT_SECRET_FILE)
          export JWT_REFRESH_SECRET=$(${pkgs.systemd}/bin/systemd-creds cat JWT_REFRESH_SECRET_FILE)
          export MEILI_MASTER_KEY=$(${pkgs.systemd}/bin/systemd-creds cat MEILI_MASTER_KEY_FILE)
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
  };
}

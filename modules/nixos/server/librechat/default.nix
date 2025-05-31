{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.server.librechat;
  configFile = pkgs.writeTextFile {
    name = "librechat.yaml";
    text = lib.generators.toYAML { } cfg.settings;
  };
in
{
  options.server.librechat = {
    enable = lib.mkEnableOption "Whether to enable the LibreChat server.";
    openFirewall = lib.mkEnableOption "Whether to open the port in the firewall.";
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
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      example = # nix
        ''
          {
            version = "1.0.8";
            cache = true;
            interface = {
              privacyPolicy = {
                externalUrl = "https://librechat.ai/privacy-policy";
                openNewTab = true;
              };
            };
            endpoints = {
              custom = [
                {
                  name = "OpenRouter";
                  # Note that the following $ should be escaped with a backslash, not '''
                  apiKey = "''${OPENROUTER_KEY}";
                  baseURL = "https://openrouter.ai/api/v1";
                  models = {
                    default = ["meta-llama/llama-3-70b-instruct"];
                    fetch = true;
                  };
                  titleConvo = true;
                  titleModule = "meta-llama/llama-3-70b-instruct";
                  dropParams = ["stop"];
                  modelDisplayLabel = "OpenRouter";
                }
              ];
            };
          }
        '';
      description = "A free-form attribute set that will be written to librechat.yaml.";
    };
  };

  config = lib.mkIf cfg.enable {
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
        ];
      };
      script = # sh
        ''
          export CONFIG_PATH=${configFile}
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

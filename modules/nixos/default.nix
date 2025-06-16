{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib.types)
    listOf
    str
    coercedTo
    submodule
    ;
  inherit (lib.pantheon) mkStrOption;
  rootDir = submodule {
    options = {
      directory = mkOption { type = str; };
      user = mkOption {
        type = str;
        default = "root";
      };
      group = mkOption {
        type = str;
        default = "root";
      };
      mode = mkOption {
        type = str;
        default = "0755";
      };
    };
  };
in
{
  options = {
    hostname = mkStrOption;
    mainUser = {
      name = mkStrOption;
      publicKey = mkStrOption;
      email = mkStrOption;
    };
    persistDirs = mkOption {
      type = listOf (coercedTo str (d: { directory = d; }) rootDir);
      default = [ ];
    };
  };

  config = {
    # Helper options
    environment.persistence."/persist".directories = config.persistDirs;

    # Global options
    persistDirs = [
      "/var/lib/systemd"
      "/var/lib/nixos"
    ];
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
    };
    nixpkgs.config.allowUnfree = true;
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      trusted-users = [ "@wheel" ];
    };
    time.timeZone = "Asia/Singapore";
    i18n.defaultLocale = "en_US.UTF-8";
    users.mutableUsers = false;
    users.groups.users = {
      gid = 100;
      members = [ "${config.mainUser.name}" ];
    };
    users.users."${config.mainUser.name}" = {
      linger = true;
      uid = 1000;
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."${config.mainUser.name}/hashedPassword".path;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [ config.mainUser.publicKey ];
    };
    users.users.root.openssh.authorizedKeys.keys = lib.singleton config.mainUser.publicKey;
    services.getty.autologinUser = config.mainUser.name;
    security.sudo.wheelNeedsPassword = false;
    sops = {
      defaultSopsFile = lib.snowfall.fs.get-file "secrets/secrets.yaml";
      age.sshKeyPaths = [ "/persist/home/rafiq/.ssh/id_ed25519" ];
      secrets = {
        "keys/openrouter" = { };
        "keys/tailscale" = { };
        "keys/gemini" = { };
        "keys/cvt-jira" = { };
        "keys/cloudflare" = { };
        "keys/telegram_bot" = { };
        "misc/cvt-jira-link" = { };
        "rafiq/hashedPassword".neededForUsers = true;
        "rafiq/personalEmailPassword" = { };
        "rafiq/workEmailPassword" = { };
        "rafiq/oldSMBCredentials" = { };
        "librechat/creds_key" = { };
        "librechat/creds_iv" = { };
        "librechat/jwt_secret" = { };
        "librechat/jwt_refresh_secret" = { };
        "librechat/meili_master_key" = { };
      };
      templates = {
        "smb-credentials".content = ''
          username=rafiq
          password=${config.sops.placeholder."rafiq/oldSMBCredentials"}
        '';
      };
    };
    environment.shellInit = # sh
      ''
        export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets."keys/gemini".path})
        export CVT_JIRA_KEY=$(sudo cat ${config.sops.secrets."keys/cvt-jira".path})
        export CVT_JIRA_LINK=$(sudo cat ${config.sops.secrets."misc/cvt-jira-link".path})
      '';
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}

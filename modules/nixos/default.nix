{
  inputs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption singleton;
  inherit (lib.types)
    listOf
    str
    coercedTo
    submodule
    ;
  inherit (lib.pantheon) mkStrOption;
  inherit (lib.snowfall.fs) get-file;
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
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix
  ];
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
    stylix.enable = true;
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    nix.settings.trusted-users = [ "@wheel" ];
    system.stateVersion = "25.05";
    time.timeZone = "Asia/Singapore";
    i18n.defaultLocale = "en_US.UTF-8";
    users = {
      # Don't allow imperative configuration
      mutableUsers = false;
      users.root.openssh.authorizedKeys.keys = [ config.mainUser.publicKey ];
      groups.users = {
        gid = 100;
        members = [ "${config.mainUser.name}" ];
      };
      users."${config.mainUser.name}" = {
        uid = 1000;
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."${config.mainUser.name}/hashedPassword".path;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = [ config.mainUser.publicKey ];
      };
    };
    security.sudo.wheelNeedsPassword = false;
    sops = {
      defaultSopsFile = get-file "secrets/secrets.yaml";
      age.sshKeyPaths = [ "/persist/home/${config.mainUser.name}/.ssh/id_ed25519" ];
      secrets = {
        "keys/openrouter" = { };
        "keys/gemini" = { };
        "keys/cloudflare" = { };
        "keys/telegram_bot" = { };
        "rafiq/hashedPassword".neededForUsers = true;
        "rafiq/personalEmailPassword" = { };
        "rafiq/workEmailPassword" = { };
      };
    };
    environment.shellInit = # sh
      ''
        export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets."keys/gemini".path})
      '';
  };
}

{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./networking.nix
    ./shell.nix
    ./stylix.nix
    ./sops.nix
    ./pipewire.nix
    inputs.nix-index-database.nixosModules.nix-index
  ];

  users.mutableUsers = false; # Always reset users on system activation
  users.users.rafiq = {
    isNormalUser = true;
    description = "rafiq";
    hashedPasswordFile = config.sops.secrets.hashed_password_rafiq.path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILv8HqazE294YdyGaXK6q2EniDlTpGaUL071kk9+W0GJ rafiq@nemesis"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICbZfOYt6zydLyO4f9JAsxb1i6kHAjYzqa0SOqef6MKM rafiq@orpheus"
    ];
  };

  environment.sessionVariables.CWP_JIRA_ACCESS_KEY_FILE =
    config.sops.secrets.cwp_jira_access_key.path;
  environment.sessionVariables.CWP_JIRA_LINK_FILE = config.sops.secrets.cwp_jira_link.path;

  security.sudo.wheelNeedsPassword = false;

  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_SG.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "-d";
  };

  programs.nix-index-database.comma.enable = true;
}

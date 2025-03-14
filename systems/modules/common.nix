{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./shell.nix
    ./stylix.nix
  ];

  users.users.rafiq = {
    isNormalUser = true;
    description = "rafiq";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILv8HqazE294YdyGaXK6q2EniDlTpGaUL071kk9+W0GJ rafiq@nemesis"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICbZfOYt6zydLyO4f9JAsxb1i6kHAjYzqa0SOqef6MKM rafiq@orpheus"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # Enable basic fonts for reasonable Unicode coverage
  fonts.enableDefaultPackages = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "@wheel"];

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
}

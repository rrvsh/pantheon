{
  inputs,
  config,
  ...
}:
{
  imports = [
    ./programs/tailscale.nix
    ./programs/zsh.nix
    inputs.nix-index-database.nixosModules.nix-index
    inputs.sops-nix.nixosModules.sops
  ];

  users.mutableUsers = false; # Always reset users on system activation
  users.users.rafiq = {
    isNormalUser = true;
    description = "rafiq";
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n rafiq"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    # Add binary caches to avoid having to compile them
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://cuda-maintainers.cachix.org"
        "https://nix-community.cachix.org"
        "https://nvf.cachix.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
  };

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

  programs.nix-index-database.comma.enable = true;

  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";

    # Configures a simple stateful firewall.
    # By default, it doesn't allow any incoming connections.
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
      ];
      allowedUDPPorts = [ ];
    };

    interfaces.enp12s0.wakeOnLan.policy = [
      "phy"
      "unicast"
      "multicast"
      "broadcast"
      "arp"
      "magic"
      "secureon"
    ];
    interfaces.enp12s0.wakeOnLan.enable = true;
  };

  services.openssh.enable = true;

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets.password.neededForUsers = true;
  };
}

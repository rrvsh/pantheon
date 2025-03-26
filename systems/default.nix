{
  lib,
  hostname,
  pkgs,
  type,
  modulesPath,
  inputs,
  config,
  specialArgs,
  username,
  ...
}:
{
  imports = builtins.concatLists [
    # Common options for all machines.
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./modules/bootloaders/systemd-boot.nix
      ./modules/programs/zsh.nix
      ./modules/hardware/networking.nix
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
    ]
    # Options for desktops.
    (lib.optionals (type == "desktop") [
      ./modules/hardware/audio.nix
      ./modules/hardware/bluetooth.nix
      ./modules/programs/getty.nix
      ./modules/programs/hyprland.nix
      ./modules/programs/hyprlock.nix
      ./modules/stylix.nix
    ])
    # Options for specific hostnames.
    (lib.optionals (hostname == "nemesis") [
      ./hw-nemesis.nix
      ./modules/hardware/nvidia.nix
      ./modules/hardware/cpu_amd.nix
    ])
  ];

  boot = {
    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
    users.${username}.imports = [ ../users/rafiq.nix ];
  };

  system.stateVersion = "24.11";

  users.mutableUsers = false; # Always reset users on system activation
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    hashedPasswordFile = config.sops.secrets.password.path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n"
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

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets.password.neededForUsers = true;
  };
}

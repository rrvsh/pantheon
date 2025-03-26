{
  inputs,
  config,
  specialArgs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./scripts
    ./programs
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
  };

  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";

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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdsZyY3gu8IGB8MzMnLdh+ClDxQQ2RYG9rkeetIKq8n"
    ];
  };

  home-manager.users.rafiq = {
    home = {
      username = "rafiq";
      homeDirectory = "/home/rafiq";

      # This defines the version home-manager
      # was originally bulit against on this system.
      # Do not change it.
      stateVersion = "25.05";

      shell.enableShellIntegration = true;
      shellAliases = {
        gs = "git status";
        ai = "aichat -r %shell% -e";
        cd = "z";
        list-all-packages = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
      };

      packages = with pkgs; [
        aichat # duh
        bat
        btop # add settings as home-manager module
        devenv
        fastfetch # system info
        hyprpicker
        inputs.hyprcloser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ripgrep
        ttyper
        wl-clipboard # provides cli copy and paste commands
      ];
    };
  };
}

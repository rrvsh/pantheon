{
  inputs,
  config,
  specialArgs,
  pkgs,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = specialArgs;
  };

  users.mutableUsers = false; # Always reset users on system activation

  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";

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
  imports = [
    ./scripts
    ./programs
  ];

  home-manager.users.rafiq.imports = [
    {
      # This enables using home-manager from the command line.
      programs.home-manager.enable = true;

      editorconfig = {
        enable = true;
        settings = {
          "*" = {
            end_of_line = "lf";
            insert_final_newline = true;
            trim_trailing_whitespace = true;
            charset = "utf-8";
            indent_style = "space";
            indent_size = 2;
          };
          "package.json" = {
            indent_style = "unset";
          };
          "*.lock" = {
            indent_size = "unset";
          };
        };
      };

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
    }
  ];
}

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

  home-manager.users.rafiq.imports = [
    ../programs_temp/ags.nix
    ../programs_temp/btop.nix
    ../programs_temp/clipse.nix
    ../programs_temp/comma.nix
    ../programs_temp/direnv.nix
    ../programs_temp/dunst.nix
    ../programs_temp/firefox.nix
    ../programs_temp/fuzzel.nix
    ../programs_temp/fzf.nix
    ../programs_temp/git.nix
    ../programs_temp/hyprland.nix
    ../programs_temp/hyprshade.nix
    ../programs_temp/kitty.nix
    ../programs_temp/nh.nix
    ../programs_temp/nvf.nix
    ../programs_temp/spicetify.nix
    ../programs_temp/starship.nix
    ../programs_temp/tealdeer.nix
    ../programs_temp/yazi.nix
    ../programs_temp/zellij.nix
    ../programs_temp/zoxide.nix
    ../programs_temp/zsh.nix
    ./scripts
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
          fastfetch # system info
          wl-clipboard # provides cli copy and paste commands
          aichat # duh
          ripgrep
          devenv
          bat
          ttyper
          hyprpicker
          inputs.hyprcloser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    }
  ];
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
}

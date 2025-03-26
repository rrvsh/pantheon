{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./programs/ags.nix
    ./programs/btop.nix
    ./programs/clipse.nix
    ./programs/comma.nix
    ./programs/direnv.nix
    ./programs/dunst.nix
    ./programs/firefox.nix
    ./programs/fuzzel.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/hyprland.nix
    ./programs/hyprshade.nix
    ./programs/kitty.nix
    ./programs/nh.nix
    ./programs/nvf.nix
    ./programs/spicetify.nix
    ./programs/starship.nix
    ./programs/tealdeer.nix
    ./programs/thefuck.nix
    ./programs/yazi.nix
    ./programs/zellij.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
    ./scripts
  ];

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

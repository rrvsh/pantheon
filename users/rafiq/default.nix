{ self, config, pkgs, inputs, ... }:

{
  home = {
    username = "rafiq";
    homeDirectory = "/home/rafiq";

    packages = [
      self.packages.${pkgs.stdenv.system}.nvf
      pkgs.kitty
      pkgs.fastfetch
      pkgs.wl-clipboard
    ];
    sessionVariables = {
      GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
    };
  };
  
  programs = {
    git = {
      enable = true;
      userName = "Mohammad Rafiq";
      userEmail = "mohammadrafiq567@gmail.com";
      extraConfig = {
        init.defaultBranch = "prime";
        push.autoSetupRemote = true;
        pull.rebase = false;
      };
    };

    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };

    tmux = {
      enable = true;
      extraConfig = ''
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"
      '';
    };
    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Required for UWSM compat
    systemd.variables = ["--all"];
    # Use tha packages defined in the system configuration
    package = null;
    portalPackage = null;
    settings = {
      monitor = [
        "HDMI-A-2, 3840x2160@60, 0x0, 2"
        "DP-4, 1920x1080@60, -1920x0, 1"
        ", preferred, auto, 1"
      ];
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, uwsm app -- $terminal"
        "$mainMod, W, killactive"
        "$mainMod, E, exec, uwsm app -- $browser"
        "$mainMod, M, exec, uwsm stop"
      ];
      debug.disable_logs = false;
    };
  };

  services = {
    cliphist.enable = true;
  };

  home.stateVersion = "25.05";
}

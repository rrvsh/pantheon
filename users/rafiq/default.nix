{ self, config, pkgs, inputs, ... }:

{
  home.username = "rafiq";
  home.homeDirectory = "/home/rafiq";

  home.packages = [
    self.packages.${pkgs.stdenv.system}.nvf
    pkgs.kitty
  ];
  
  programs.git = {
    enable = true;
    userName = "rafiq";
    userEmail = "mohammadrafiq567@gmail.com";
    extraConfig = {
      init.defaultBranch = "prime";
    };
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
    };
  };


  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}

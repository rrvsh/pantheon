{ config, pkgs, inputs, ... }:

{
  home.username = "rafiq";
  home.homeDirectory = "/home/rafiq";

  # home.file.".config/" = {
  #   source = ./.config;
  #   recursive = true;
  # };

  home.file."bin" = {
    source = ../../scripts;
    recursive = true;
    executable = true;
  };

  home.packages = with pkgs; [
    fastfetch
    neovim
    zip
    unzip
    ripgrep
    wl-clipboard
    thefuck
  ];
  
  home.sessionVariables = {
    GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
  };

  programs.git = {
    enable = true;
    userName = "Mohammad Rafiq";
    userEmail = "mohammadrafiq567@gmail.com";
    extraConfig = {
      init.defaultBranch = "prime";
      push.autoSetupRemote = true;
      pull.rebase = false;
    };
  };

  programs.gh = {
    enable = true;
  };

  programs.lazygit.enable = true;

  #TODO add neovim option

  #TODO add starship

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      l = "ls -l --human-readable --file-type --almost-all";
    };
    bashrcExtra = ''
      eval $(thefuck --alias)
      export PATH="$PATH:$HOME/bin"      
    '';
  };
  
  wayland.windowManager.hyprland = {
    enable = true;

    # Set these to null to use the packages defined in the system config.
    package = null;
    portalPackage = null;

    plugins = with pkgs.hyprlandPlugins; [
      # borders-plus-plus
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.<plugin>
      # hypr-dynamic-cursors # requires notifications set up
    ];

    settings = {
     monitor = [
       "HDMI-A-1, 3840x2160@60, 0x0, 2"
       "DP-6, 1920x1080@60, -1920x0, 1"
       ",  preferred, auto, 1"
     ];
     "$mainMod" = "SUPER"; # Windows key
     "$mod" = "CTRL";
     "$terminal" = "kitty";
     "$browser" = "firefox";
     bind = [
       "$mainMod, Q, exec, $terminal"
       "$mainMod, W, killactive"
       "$mainMod, E, exec, $browser"
     ];
     bindm = [
       "$mod, mouse:272, movewindow"
     ];
     debug = {
       disable_logs = false;
     };
    };
  };

  services.cliphist.enable = true;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}

  

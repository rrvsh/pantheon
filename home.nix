{ config, pkgs, inputs, ... }:

{
  home.username = "rafiq";
  home.homeDirectory = "/home/rafiq";

  # home.file.".config/" = {
  #   source = ./.config;
  #   recursive = true;
  # };

  home.packages = with pkgs; [
    fastfetch
    neovim
    zip
    unzip
    ripgrep
  ];
  
  programs.git = {
    enable = true;
    userName = "Mohammad Rafiq";
    userEmail = "mohammadrafiq567@gmail.com";
  };

  #TODO add neovim option

  #TODO add starship

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      l = "ls -l --human-readable --file-type --almost-all";
    };
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
     "$mainMod" = "SUPER"; # Sets the modifier key to Windows key
     "$terminal" = "kitty";
     bind = [
       "$mainMod, Q, exec, $terminal"
       "$mainMod, W, killactive"
     ];
     debug = {
       disable_logs = false;
     };
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}

  

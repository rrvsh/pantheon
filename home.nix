{ config, pkgs, ... }:

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
  
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}

  

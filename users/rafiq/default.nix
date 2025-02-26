{ config, pkgs, inputs, ... }:

{
  home.username = "rafiq";
  home.homeDirectory = "/home/rafiq";
  
  programs.git = {
    enable = true;
    userName = "rafiq";
    userEmail = "mohammadrafiq567@gmail.com";
    extraConfig = {
      init.defaultBranch = "prime";
    };
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}

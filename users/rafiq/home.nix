{ config, pkgs, ... }:

{
  home.username = "rafiq";
  home.homeDirectory = "/home/rafiq";

  home.stateVersion = "24.11"

  programs.home-manager.enable = true;

  # Git Configuration
  programs.git = {
    enable = true;
    userName = "Mohammad Rafiq";
    userEmail = "mohammadrafiq567@gmail.com";
  };
}

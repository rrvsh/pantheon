{ config, pkgs, osConfig, ... }:

{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    git
    neovim
    ripgrep
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

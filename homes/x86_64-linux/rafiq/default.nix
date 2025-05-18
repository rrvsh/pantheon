{ config, pkgs, osConfig, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/hyprland.nix
  ];

  home.stateVersion = "24.11";

  home.file = {
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
    kitty
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.persistence."/persist/home/rafiq" = {
directories = [
".ssh"
"repos"
];
allowOther = true;
  };
}

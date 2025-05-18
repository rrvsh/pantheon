{ config, pkgs, osConfig, ... }:

{
  imports = [
    ./programs/git.nix
  ];

  home.stateVersion = "24.11";

  home.file = {
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
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

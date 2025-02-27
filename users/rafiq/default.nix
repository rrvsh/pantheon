{ self, pkgs, ... }:

{
  imports = [
    ../../modules/home-git.nix
    ../../modules/home-tmux.nix
    ../../modules/home-sh.nix
    ../../modules/home-wm.nix
  ];

  home = {
    username = "rafiq";
    homeDirectory = "/home/rafiq";

    packages = [
      self.packages.${pkgs.stdenv.system}.nvf
      pkgs.kitty
      pkgs.fastfetch
      pkgs.wl-clipboard
    ];
  };
  
  programs = {
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };

    home-manager.enable = true;
  };

  services = {
    cliphist.enable = true;
  };

  home.stateVersion = "25.05";
}

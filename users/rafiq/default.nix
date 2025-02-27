{ self, pkgs, ... }:

{
  imports = [
    ../../modules/home-git.nix # git specific configs
    ../../modules/home-tmux.nix # tmux specific configs (might move this)
    ../../modules/home-sh.nix # bash and other shell specific configs
    ../../modules/home-wm.nix # window manager configs
    ../../modules/home-editor.nix # editor specific configs
    ../../modules/home-terminal.nix # terminal emulator configs
  ];

  home = {
    username = "rafiq";
    homeDirectory = "/home/rafiq";

    packages = [
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

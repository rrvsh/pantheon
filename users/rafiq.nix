{ self, pkgs, ... }:

{
  imports = [
    ../../modules/home-git.nix # git specific configs
    ../../modules/home-tmux.nix # tmux specific configs (might move this)
    ../../modules/home-sh.nix # bash and other shell specific configs
    ../../modules/home-wm.nix # window manager configs
    ../../modules/home-editor.nix # editor specific configs
    ../../modules/home-terminal.nix # terminal emulator configs
    ../../modules/home-utils.nix # miscellaneous utilities
  ];

  # This enables using home-manager from the command line.
  programs.home-manager.enable = true;

  home = {
    username = "rafiq";
    homeDirectory = "/home/rafiq";

    # This defines the version home-manager
    # was originally bulit against on this system.
    # Do not change it.
    stateVersion = "25.05";
  };
}

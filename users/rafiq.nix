{pkgs, ...}: {
  imports = [
    ./modules/sh.nix
    ./modules/de.nix
    ./modules/utils.nix
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

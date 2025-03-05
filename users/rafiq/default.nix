_: {
  imports = [
    ./modules/git.nix # git specific configs
    ./modules/sh.nix # bash and other shell specific configs
    ./modules/nvim.nix # nvim specific configs
    ./modules/terminal.nix # terminal emulator configs
    ./modules/firefox.nix # firefox configs
    ./modules/hyprland.nix # hyprland settings
    ./modules/utils.nix # miscellaneous utilities
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

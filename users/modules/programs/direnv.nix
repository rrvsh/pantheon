{
    # direnv lets us declare a .envrc in each project directory
    # and updates the shell with the packages specified.
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
}

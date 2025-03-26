{
  # direnv lets us declare a .envrc in each project directory
  # and updates the shell with the packages specified.

  home-manager.users.rafiq = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

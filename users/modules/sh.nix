{
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake";
      gs = "git status";
      ai = "aichat -r %shell% -e";
    };
  };

  # direnv lets us declare a .envrc in each project directory
  # and updates the shell with the packages specified.
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}

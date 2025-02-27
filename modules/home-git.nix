{
  home.sessionVariables.GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";

  programs.git = {
    enable = true;
    userName = "Mohammad Rafiq";
    userEmail = "mohammadrafiq567@gmail.com";
    extraConfig = {
      init.defaultBranch = "prime";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.editor = "nvim";
    };
  };
}

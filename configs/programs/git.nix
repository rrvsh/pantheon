{
  home-manager.users.rafiq = {
    home.sessionVariables.GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";

    programs.git = {
      enable = true;
      userName = "Mohammad Rafiq";
      userEmail = "mohammadrafiq567@gmail.com";
      signing.key = "~/.ssh/id_ed25519.pub";
      signing.signByDefault = true;
      extraConfig = {
        init.defaultBranch = "prime";
        push.autoSetupRemote = true;
        pull.rebase = false;
        core.editor = "nvim";
        gpg.format = "ssh";
      };
    };
  };
}

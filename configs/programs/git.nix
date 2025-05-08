{
  home-manager.users.rafiq = {
    home.sessionVariables.GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
    home.shellAliases = {
      g = "git";
      gs = "git status";
    };

    programs.git = {
      enable = true;
      userName = "Mohammad Rafiq";
      userEmail = "rafiq@rrv.sh";
      # Thanks to https://blog.notashelf.dev/posts/2025-02-24-ssh-signing-commits.html!
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

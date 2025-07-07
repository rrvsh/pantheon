{
  flake.homes.rafiq = {
    # Testing the import in home-manager.nix
    home.shellAliases = {
      gs = "git status";
      gc = "git commit";
      gcam = "git commit -am";
      gu = "git push";
      gy = "git pull";
      gdh = "git diff HEAD";
    };
    programs.git = {
      signing.signByDefault = true;
      extraConfig = {
        init.defaultBranch = "prime";
        push.autoSetupRemote = true;
        pull.rebase = false;
        core.editor = "$EDITOR";
        gpg.format = "ssh";
      };
    };
  };
}

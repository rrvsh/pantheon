{
  flake.modules.homeManager.rafiq = {
    home.shellAliases = {
      gs = "git status";
      gc = "git commit";
      gcam = "git commit -am";
      gu = "git push";
      gy = "git pull";
      gdh = "git diff HEAD";
    };
    programs.git = {
      enable = true;
      signing.signByDefault = true;
      delta = {
        enable = true;
        options = {
          hyperlinks = true;
          hyperlinks-file-link-format = "$EDITOR +{line} {path}";
        };
      };
      extraConfig = {
        core.editor = "$EDITOR";
        gpg.format = "ssh";
        init.defaultBranch = "prime";
        merge.conflictStyle = "zdiff3";
        pull.rebase = false;
        push.autoSetupRemote = true;
      };
    };
  };
}

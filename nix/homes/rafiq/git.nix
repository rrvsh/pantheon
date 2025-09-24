{
  flake.modules.homeManager.rafiq = {
    home.shellAliases = {
      gs = "git status";
      gc = "git commit";
      gcam = "git commit -am";
      gu = "git push";
      gy = "git pull";
      gd = "git diff";
      gdh = "git diff HEAD";
      gdm = "git diff main"; #FIXME: set to default branch name
      grhh = "git reset --hard HEAD";
      gush = "git add . && git stash && git checkout main && git pull && git checkout - && git rebase main && git push -f --no-verify";
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

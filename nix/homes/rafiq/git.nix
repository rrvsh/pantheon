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
      gdm = "git diff $(default-branch)";
      grhh = "git reset --hard HEAD";
      gush = "git add . && git stash && git checkout $(default-branch) && git pull && git checkout - && git rebase $(default-branch) && git push -f --no-verify";
      gus = "git add . && git stash && git checkout $(default-branch) && git pull && git checkout - && git rebase $(default-branch)";
      default-branch = "git rev-parse --abbrev-ref origin/HEAD | cut -d'/' -f2-";
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

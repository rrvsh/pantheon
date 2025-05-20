{ lib, config, ... }:
{
  config = {
    home.sessionVariables.GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
    home.shellAliases = {
      gs = "git status";
      gc = "git commit";
      gcam = "git commit -am";
      gu = "git push";
      gy = "git pull";
    };
    programs.git = {
      enable = true;
      userName = config.cli.git.name;
      userEmail = config.cli.git.email;
      signing.key = "~/.ssh/id_ed25519.pub";
      signing.signByDefault = true;
      extraConfig = {
        init.defaultBranch = config.cli.git.defaultBranch;
        push.autoSetupRemote = true;
        pull.rebase = false;
        core.editor = "$EDITOR";
        gpg.format = "ssh";
      };
    };
  };
}

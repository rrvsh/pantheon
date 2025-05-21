{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.shell == "zsh") {
    home.sessionVariables.SHELL = "zsh";
    programs.zsh = {
      enable = true;
      enableVteIntegration = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      history = {
        append = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        save = 10000;
        share = true;
        size = 10000;
      };
    };
    programs.zsh.initContent = lib.mkIf config.cli.screensaver.enable (
      lib.mkOrder 1200
        # zsh
        ''
          precmd() {
            TMOUT=${config.cli.screensaver.timeout}
          }

          TRAPALRM() {
            TMOUT=1
            ${config.cli.screensaver.command}
            # If we exit, assume the previous command was exited out of
            TMOUT=${config.cli.screensaver.timeout}
            zle reset-prompt
          }
        ''
    );
  };
}

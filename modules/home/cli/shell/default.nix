{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.shell == "zsh") {
    home.sessionVariables.SHELL = "zsh";
    home.persistence."/persist/home/${config.snowfallorg.user.name}".files = [ ".zsh_history" ];
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
    programs.zsh.initContent = lib.mkIf config.cli.enableScreensaver (
      lib.mkOrder 1200
        # zsh
        ''
          setopt PROMPT_SUBST
          PROMPT='> '
          RPROMPT='[%D{%L:%M:%S %p}]'

          TMOUT=1

          TRAPALRM() {
              zle reset-prompt
          }
        ''
    );
  };
}

{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.shell == "zsh") {
    home.sessionVariables.SHELL = "zsh";
    programs.zsh = {
      enable = true;
      enableVteIntegration = true;
      syntaxHighlighting.enable = true;
      history.share = true;
      history.size = 10000;
      history.ignoreDups = true;
      history.ignoreSpace = true;
      initContent =
        lib.mkOrder 1200
          # zsh
          ''
            RPROMPT='[%D{%L:%M:%S %p}]'

            TMOUT=1

            TRAPALRM() {
                zle reset-prompt
            }
          '';
    };
  };
}

{ lib, pkgs, ... }:
let
  inherit (builtins) toString;
  inherit (lib) mkOrder;
  screensaverTimeout = toString 100;
  screensaverCommand = "${pkgs.cbonsai}/bin/cbonsai -S -w 0.1 -L 40 -M 2 -b 2";
in
{
  home.shell.enableShellIntegration = true;
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
  programs.zsh.initContent =
    mkOrder 1200
      # zsh
      ''
        precmd() {
          TMOUT=${screensaverTimeout}
        }

        TRAPALRM() {
          TMOUT=1
          ${screensaverCommand}
          # If we exit, assume the previous command was exited out of
          TMOUT=${screensaverTimeout}
          zle reset-prompt
        }
      '';
}

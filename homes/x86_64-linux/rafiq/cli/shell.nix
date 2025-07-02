{ lib, pkgs, ... }:
let
  inherit (builtins) toString;
  inherit (lib) getExe mkOrder;
  screensaverTimeout = toString 100;
  screensaverCommand = "${getExe pkgs.cbonsai} -S -w 0.1 -L 40 -M 2 -b 2";
in
{
  home.shell.enableShellIntegration = true;
  home.sessionVariables.SHELL = "fish";
  programs.fish.enable = true;
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

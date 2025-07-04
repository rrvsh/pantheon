{ lib, pkgs, ... }:
let
  inherit (builtins) toString;
  inherit (lib) getExe mkOrder;
  inherit (lib.strings) concatStrings;
  screensaverTimeout = toString 100;
  screensaverCommand = "${getExe pkgs.cbonsai} -S -w 0.1 -L 40 -M 2 -b 2";
in
{
  home.shell.enableShellIntegration = true;
  home.sessionVariables.SHELL = "fish";
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = concatStrings [
        # First Line
        ## Left Prompt
        "$hostname$directory"
        "$fill"
        ## Right Prompt
        "$all"
        # Second Line
        ## Left Prompt
        "$character"
      ];
      git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
      shlvl.disabled = false;
      username.disabled = true;
      fill.symbol = " ";
    };
  };
  # figure out for fish
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

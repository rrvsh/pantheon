{ lib, ... }:
let
  inherit (lib.strings) concatStrings;
in
{
  programs.starship = {
    enable = false;
    # settings = {
    #   add_newline = false;
    #   format = concatStrings [
    #     # First Line
    #     ## Left Prompt
    #     "$hostname$directory"
    #     "$fill"
    #     ## Right Prompt
    #     "$all"
    #     # Second Line
    #     ## Left Prompt
    #     "$character"
    #   ];
    #   git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
    #   shlvl.disabled = false;
    #   username.disabled = true;
    #   fill.symbol = " ";
    # };
  };
}

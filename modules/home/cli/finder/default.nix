{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.cli.finder == "fzf") {
      programs.fzf = {
        enable = true;
        enableZshIntegration = lib.mkIf (config.cli.shell == "zsh") true;
      };
    })
  ];
}

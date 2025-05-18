{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletions = true;
    autosuggestion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    history.share = true;
    history.size = 10000;
    history.ignoreDups = true;
    history.ignoreSpace = true;
  };
}

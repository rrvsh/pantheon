{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    history.share = true;
    history.size = 10000;
    history.ignoreDups = true;
    history.ignoreSpace = true;
  };
}

{
  home.sessionVariables.TERMINAL = "ghostty -e";
  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
    };
  };
}

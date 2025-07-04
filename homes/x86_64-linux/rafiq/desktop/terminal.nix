{
  home.sessionVariables.TERMINAL = "ghostty";
  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
    };
  };
}

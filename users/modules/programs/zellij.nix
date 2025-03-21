{
  programs.zellij = {
    enable = true;
    # package = inputs.zellij blablabla
    settings = {
      # theme = "stylix";
    };
  };
  home.sessionVariables.ZELLIJ_AUTO_ATTACH = "true";
  home.sessionVariables.ZELLIJ_AUTO_EXIT = "true";
}


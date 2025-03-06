{
  programs.kitty = {
    enable = true;
    # font = {
    #   name = "";
    #   package = ?;
    #   size = 32;
    # };
    keybindings = {
      "ctrl+equal" = "change_font_size current +2.0";
      "ctrl+minus" = "change_font_size current -2.0";
    };
  };
}

{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+equal" = "change_font_size current +2.0";
      "ctrl+minus" = "change_font_size current -2.0";
    };
    settings = {
      window_padding_width = 10;
    };
  };
}

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Terminess Nerd Font Mono";
      size = 16;
    };
    keybindings = {
      "ctrl+equal" = "change_font_size current +2.0";
      "ctrl+minus" = "change_font_size current -2.0";
    };
  };
}

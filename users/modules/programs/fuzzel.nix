{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty -1 -e";
        layer = "top";
        keyboard-focus = "on-demand";
        list-executables-in-path = true;
      };
    };
  };
}

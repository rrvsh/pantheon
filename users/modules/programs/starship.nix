{
  # starship is a customisable prompt for any shell
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$character";
      right_format = "$all";
    };
  };
}

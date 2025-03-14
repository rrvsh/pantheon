{
  # starship is a customisable prompt for any shell
  programs.starship = {
    enable = true;
    settings = {
      format = "$character";
      right_format = "$all";
    };
  };
}

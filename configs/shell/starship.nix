{
  home-manager.users.rafiq = {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = "$character";
        right_format = "$all";
        character = {
          success_symbol = "[\\$](bold green)";
          error_symbol = "[\\$](bold red)";
        };
      };
    };
  };
}

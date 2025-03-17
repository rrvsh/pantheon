{pkgs, ...}: {
  programs.hyprlock = {
    enable = true;
    package = null;

    settings = {
      general.hide_cursor = true;

      input-field = {
        fade_on_empty = false;
      };
    };
  };
}

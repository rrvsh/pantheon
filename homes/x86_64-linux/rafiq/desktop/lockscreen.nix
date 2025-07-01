let
  styling = {
    halign = "center";
    valign = "center";
    zindex = 1;
    shadow_passes = 5;
    shadow_size = 5;
  };
in
{
  home.sessionVariables.LOCKSCREEN = "hyprlock";
  programs.hyprlock.settings = {
    general.hide_cursor = true;
    general.ignore_empty_input = true;
    background.blur_passes = 5;
    background.blur_size = 5;
    label = {
      text = ''hi, $USER.'';
      font_size = 32;
      position = "0, 0";
    }// styling;
    input-field = {
      placeholder_text = "";
      fade_on_empty = true;
      size = "200, 45";
      position = "0, -5%";
    } // styling;
  };
}

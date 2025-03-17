{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    package = null;

    settings = {
      "$mainMonitor" = "desc:OOO AN-270W04K";
      "$vertMonitor" = "desc:Philips Consumer Electronics Company PHL 246V5 AU11330000086";
      general.hide_cursor = true;

      label = {
        monitor = "HDMI-A-1";
        text = ''hi, $USER.'';
        font_size = 32;
        halign = "center";
        valign = "center";
        position = "0, 0";
        zindex = 1;
      };
      input-field = {
        monitor = "HDMI-A-1";
        fade_on_empty = true;
        size = "200, 45";
        halign = "center";
        valign = "center";
        position = "0, -5%";
        placeholder_text = "";
        zindex = 1;
      };
    };
  };
}

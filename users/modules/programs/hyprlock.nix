{ pkgs, osConfig, ... }:
let
  cfg =
    if osConfig.networking.hostName == "nemesis" then
      {
        mainMonitor = "desc:OOO AN-270W04K";
      }
    else
      {
        mainMonitor = "";
      };
in
{
  programs.hyprlock = {
    enable = true;
    package = null;

    settings = {
      general.hide_cursor = true;

      label = {
        monitor = cfg.mainMonitor;
        text = ''hi, $USER.'';
        font_size = 32;
        halign = "center";
        valign = "center";
        position = "0, 0";
        zindex = 1;
      };
      input-field = {
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

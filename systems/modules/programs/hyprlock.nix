{
  inputs,
  hostname,
  pkgs,
  username,
  ...
}:
let
  cfg =
    if hostname == "nemesis" then
      {
        mainMonitor = "HDMI-A-1";
      }
    else
      {
        mainMonitor = "";
      };
in
{
  security.pam.services.hyprlock = { };
  home-manager.users.${username} = {
    programs.hyprlock = {
      enable = true;
      package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;

      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };

        background = {
          blur_passes = 5;
          blur_size = 5;
        };

        label = {
          monitor = cfg.mainMonitor;
          text = ''hi, $USER.'';
          font_size = 32;
          halign = "center";
          valign = "center";
          position = "0, 0";
          zindex = 1;
          shadow_passes = 5;
          shadow_size = 5;
        };

        input-field = {
          fade_on_empty = true;
          size = "200, 45";
          halign = "center";
          valign = "center";
          position = "0, -5%";
          placeholder_text = "";
          zindex = 1;
          shadow_passes = 5;
          shadow_size = 5;
        };
      };
    };
  };
}

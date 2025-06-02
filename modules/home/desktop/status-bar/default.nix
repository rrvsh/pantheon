{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (osConfig.desktop.status-bar == "waybar") {
      home.sessionVariables.STATUS_BAR = "waybar";
      programs.waybar = {
        enable = true;
        settings = [
          {
            layer = "top";
            modules-left = [
              "pulseaudio"
            ];
            modules-right = [
              "battery"
              "clock"
            ];
            "pulseaudio" = {
              format = "{icon} {volume}%";
              format-muted = "";
              format-icons.default = [
                ""
                ""
              ];
              on-click = "${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
            };
            "clock" = {
              interval = 1;
              format = "{:%F %T}";
            };
            "battery" = {
              interval = 1;
              bat-compatibility = true;
            };
          }
        ];
        style = # css
          ''
            window#waybar {
              background-color: rgba(0, 0, 0, 0);
            }

            #pulseaudio,
            #battery,
            #clock {
              padding-top: 5px;
              padding-bottom: 5px;
              padding-right: 5px;
              color: #ffffff;
            }
          '';
      };
    })
  ];
}

{
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
            modules-right = [ "clock" ];
          }
        ];
      };
    })
  ];
}

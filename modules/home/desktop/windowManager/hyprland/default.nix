{ config, lib, osConfig, ... }:
let
  mainMonitor = osConfig.desktop.mainMonitor;
in
{
  imports = [

  ];

  config = lib.mkIf (config.desktop.windowManager == "hyprland") (lib.mkMerge [
    {
  xdg.configFile."uwsm/env".text = # sh
  ''
  
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      ecosystem.no_update_news = true;
      "$hypr" = "CTRL_SUPER_ALT_SHIFT";

          monitor = [
            "${mainMonitor.id}, ${mainMonitor.resolution}@${mainMonitor.refresh-rate}, auto, ${mainMonitor.scale}"
            ", preferred, auto, 1"
          ];

      bind = [
        "$hypr, Q, exec, uwsm stop"
	"SUPER, W, killactive"

	"SUPER, return, exec, uwsm app -- $TERMINAL"
	"SUPER, O, exec, uwsm app -- $BROWSER"

            "SUPER, H, cyclenext, visible"
            "SUPER, L, cyclenext, visible prev"
            "SUPER_ALT, H, movewindow, l"
            "SUPER_ALT, J, movewindow, d"
            "SUPER_ALT, K, movewindow, u"
            "SUPER_ALT, L, movewindow, r"
            "ALT_SHIFT, H, resizeactive, -10% 0"
            "ALT_SHIFT, J, resizeactive, 0 -10%"
            "ALT_SHIFT, K, resizeactive, 0 10%"
            "ALT_SHIFT, L, resizeactive, 10% 0"
            "SUPER_CTRL, H, workspace, r-1"
            "SUPER_CTRL, L, workspace, r+1"
            "$hypr, H, movetoworkspace, r-1"
            "$hypr, L, movetoworkspace, r+1"
      ];
    };
  };
    }
  ]);
}

{config, lib, osConfig, ...}:
{
  xdg.configFile."uwsm/env".text = # sh
  ''
  
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$hypr" = "CTRL_SUPER_ALT_SHIFT";
      bind = [
        "$hypr, Q, exec, uwsm stop"
	"SUPER, W, killactive"

	"SUPER, return, exec, uwsm app -- $TERMINAL"

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

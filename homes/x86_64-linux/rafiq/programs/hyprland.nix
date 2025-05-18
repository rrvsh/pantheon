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
      ];
    };
  };
}

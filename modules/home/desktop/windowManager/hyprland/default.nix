{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
let
  mainMonitor = osConfig.desktop.mainMonitor;
in
{
  config = lib.mkIf (config.desktop.windowManager == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = lib.mkMerge [
        {
          ecosystem.no_update_news = true;

          monitor = [
            "${mainMonitor.id}, ${mainMonitor.resolution}@${mainMonitor.refresh-rate}, auto, ${mainMonitor.scale}"
            ", preferred, auto, 1"
          ];

          exec-once = [
            "uwsm app -- $LOCKSCREEN"
            "uwsm app -- $NOTIFICATION_DAEMON"
          ];
        }
        (import ./decoration.nix)
        (import ./keybinds.nix { inherit pkgs; })
      ];
    };
    xdg.configFile."uwsm/env".text = # sh
      ''

      '';
  };
}

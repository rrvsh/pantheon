{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib) mkMerge;
  inherit (osConfig.desktop) mainMonitor;
in
mkMerge [
  (import ./decoration.nix)
  (import ./keybinds.nix { inherit pkgs; })
  {
    ecosystem.no_update_news = true;
    xwayland.force_zero_scaling = true;

    monitor = [
      "${mainMonitor.id}, ${mainMonitor.resolution}@${mainMonitor.refresh-rate}, auto, ${mainMonitor.scale}"
      ", preferred, auto, 1"
    ];

    exec-once = [
      "uwsm app -- $LOCKSCREEN"
      "uwsm app -- $NOTIFICATION_DAEMON"
      "uwsm app -- $STATUS_BAR"
    ];

  }
]

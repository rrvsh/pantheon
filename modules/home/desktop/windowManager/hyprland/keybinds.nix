{ pkgs, ... }:
{
  "$hypr" = "CTRL_SUPER_ALT_SHIFT";
  "$meh" = "CONTROL_SHIFT_ALT";
  bind = [
    "$hypr, Q, exec, uwsm stop"
    "SUPER, W, killactive"

    "SUPER, return, exec, uwsm app -- $TERMINAL $MULTIPLEXER"
    "SUPER, O, exec, uwsm app -- $BROWSER"
    "SUPER, Escape, exec, uwsm app -- $LOCKSCREEN"

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

  bindle = [
    "SUPER, 6, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
    "SUPER, 7, exec, ${pkgs.playerctl}/bin/playerctl previous"
    "SUPER, 8, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
    "SUPER, 9, exec, ${pkgs.playerctl}/bin/playerctl next"
    "SUPER, 0, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
    "$meh, mouse_up, resizeactive, 10% 10%"
    "$meh, mouse_down, resizeactive, -10% -10%"
  ];
}

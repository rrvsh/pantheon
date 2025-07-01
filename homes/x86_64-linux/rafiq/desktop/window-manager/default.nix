{ lib, pkgs, ... }:
let
  inherit (lib) mkMerge;
in
{
  wayland.windowManager.hyprland.settings = mkMerge [
    (import ./_hyprland/decoration.nix)
    (import ./_hyprland/keybinds.nix { inherit pkgs; })
    {
      ecosystem.no_update_news = true;
      xwayland.force_zero_scaling = true;
      monitor = [ ", preferred, auto, 1" ];
      exec-once = [
        "uwsm app -- $LOCKSCREEN"
        "uwsm app -- $NOTIFICATION_DAEMON"
        "uwsm app -- $STATUS_BAR"
      ];
    }
  ];
  # TODO: add gamescope here or in nixos desktop module
}

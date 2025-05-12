{
  config,
  lib,
  pkgs,
  ...
}:
let
  moduleName = "de";
  username = config.nixosModules.mainUser;
in
{
  imports = [ ];

  options.${moduleName} = {
  };

  config = lib.mkMerge [
    (lib.mkIf (config.de.type == "hyprland") {
      home-manager.users."${username}" = {
        xdg.configFile."uwsm/env".text = # sh
          ''
            export XCURSOR_SIZE=32

            # Nvidia Settings
            export LIBVA_DRIVER_NAME=nvidia
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export NVD_BACKEND=direct # needed for running vaapi-driver on later drivers"
            export NIXOS_OZONE_WL=1
          '';
        wayland.windowManager.hyprland = {
          enable = true;
          package = null;
          portalPackage = null;
          systemd.enable = false;
          settings = {
            "$mainMonitor" = "desc:OOO AN-270W04K";
            "$vertMonitor" = "desc:Philips Consumer Electronics Company PHL 246V5 AU11330000086";
            "$mainMod" = "SUPER";
            "$hyper" = "CONTROL_SHIFT_ALT_SUPER";
            "$meh" = "CONTROL_SHIFT_ALT";

            "$terminal" = "uwsm app -- kitty -1";
            "$browser" = "uwsm app -- firefox";
            "$launcher" = "uwsm app -- fuzzel";
            "$lockscreen" = "uwsm app -- hyprlock";

            "$clipboard" = "$terminal --class clipse -e clipse";
            "$multiplexer" = "$terminal -e zellij";

            exec-once = [
              "uwsm app -- hyprlock"
              "uwsm app -- clipse -listen"
              "uwsm app -- hyprcloser"
              "uwsm app -- waybar"
            ];

            # Programs to run at startup
            exec = [
              "uwsm app -- hyprshade auto"
            ];

            # Monitors
            monitor = [
              "$mainMonitor, 3840x2160@60, auto, 2"
              "$vertMonitor, 1920x1080@60, auto-left, auto, transform, 3"
              ", preferred, auto, 1"
            ];

            xwayland.force_zero_scaling = true;

            env = [
              "GDK_SCALE,2"
              "XCURSOR_SIZE,32"
            ];

            # Switching to the current workspace will switch to the previous
            binds.workspace_back_and_forth = true;
            cursor.default_monitor = "$mainMonitor";

            # Windows
            general = {
              # Make there be no gaps in between windows or edges
              border_size = 0;
              no_border_on_floating = true;
              gaps_in = 0;
              gaps_out = 0;
              resize_on_border = true;
            };

            decoration = {
              active_opacity = 1;
              inactive_opacity = 0.9;
            };

            windowrulev2 = [
              "float, class:firefox, title:Picture-in-Picture"
              "float, class:(clipse)"
              "move cursor 0 0, class:(clipse)"
              "size 622 652, class:(clipse)"
              "noanim, class:(clipse)"
            ];

            animation = [
              "workspaces, 0, , "
            ];

            # Keybinds
            bind = [
              "$mainMod, W, killactive"
              "$mainMod, M, exec, uwsm stop"
              "$mainMod, Up, fullscreen"

              # Launch utilities
              "$mainMod, return, exec, $multiplexer"
              "$mainMod, O, exec, $browser"
              "$mainMod, Escape, exec, $lockscreen"
              "$mainMod, Space, exec, $launcher"
              "$mainMod, V, exec, $clipboard"
              "$mainMod_SHIFT, A, exec, hyprpicker -a"

              # Window Settings
              "$mainMod, H, cyclenext, visible"
              "$mainMod, L, cyclenext, visible prev"
              "$mainMod_ALT, H, movewindow, l"
              "$mainMod_ALT, J, movewindow, d"
              "$mainMod_ALT, K, movewindow, u"
              "$mainMod_ALT, L, movewindow, r"
              "ALT_SHIFT, H, resizeactive, -10% 0"
              "ALT_SHIFT, J, resizeactive, 0 -10%"
              "ALT_SHIFT, K, resizeactive, 0 10%"
              "ALT_SHIFT, L, resizeactive, 10% 0"

              # Workspace Settings
              "$mainMod_CTRL, H, workspace, r-1"
              "$mainMod_CTRL, L, workspace, r+1"
              "$hyper, H, movetoworkspace, r-1"
              "$hyper, L, movetoworkspace, r+1"
            ];

            # Repeat when held
            bindle = [
              "SUPER, 6, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
              "SUPER, 7, exec, ${pkgs.playerctl}/bin/playerctl previous"
              "SUPER, 8, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
              "SUPER, 9, exec, ${pkgs.playerctl}/bin/playerctl next"
              "SUPER, 0, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
            ];

            bindm = [
              "$meh, mouse:272, movewindow"
            ];

            input = {
              numlock_by_default = true;
              follow_mouse = 2; # Click on a window to change focus
            };

            debug = {
              damage_tracking = 0;
            };
          };
        };
      };
    })
  ];
}

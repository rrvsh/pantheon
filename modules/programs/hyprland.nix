{ pkgs, ... }:
{
  environment.loginShellInit = # sh
    ''
      if [[ -z "$SSH_CLIENT" && -z "$SSH_CONNECTION" ]]; then
        if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
        fi
      fi
    '';

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  home-manager.users.rafiq = {
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

        "$terminal" = "uwsm app -- kitty -1";
        "$browser" = "uwsm app -- firefox";
        "$launcher" = "uwsm app -- fuzzel";
        "$lockscreen" = "uwsm app -- hyprlock";

        "$clipboard" = "$terminal --class clipse -e clipse";
        "$multiplexer" = "$terminal -e zellij";

        # Programs to run at startup
        exec-once = [
          "uwsm app -- hyprlock"
          "uwsm app -- clipse -listen"
          "uwsm app -- hyprcloser"
          "uwsm app -- hyprshade auto"
        ];

        # Monitors
        monitor = [
          "$mainMonitor, 3840x2160@60, auto, 2"
          "$vertMonitor, 1920x1080@60, auto-left, auto, transform, 3"
          ", preferred, auto, 1"
        ];

        # Switching to the current workspace will switch to the previous
        binds.workspace_back_and_forth = true;
        cursor.default_monitor = "$mainMonitor";

        # Windows
        general = {
          # Make there be no gaps in between windows or edges
          border_size = 5;
          gaps_in = 20;
          gaps_out = 20;

          resize_on_border = true;
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

          # Launch utilities
          "$mainMod, return, exec, $multiplexer"
          "$mainMod, O, exec, $browser"
          "$mainMod, Escape, exec, $lockscreen"
          "$mainMod, Space, exec, $launcher"
          "$mainMod, V, exec, $clipboard"
          "$mainMod_SHIFT, A, exec, hyprpicker -a"

          # move between windows
          "$mainMod, H, cyclenext, visible"
          "$mainMod, L, cyclenext, visible prev"

          # HJKL to move a window
          "$mainMod_ALT, H, movewindow, l"
          "$mainMod_ALT, J, movewindow, d"
          "$mainMod_ALT, K, movewindow, u"
          "$mainMod_ALT, L, movewindow, r"

          # HJKL to resize a window
          "ALT_SHIFT, H, resizeactive, -10% 0"
          "ALT_SHIFT, J, resizeactive, 0 -10%"
          "ALT_SHIFT, K, resizeactive, 0 10%"
          "ALT_SHIFT, L, resizeactive, 10% 0"

          # H and L to move between workspaces on the current monitor including creation
          "$mainMod_CTRL, H, workspace, r-1"
          "$mainMod_CTRL, L, workspace, r+1"

          "SUPER, 7, exec, ${pkgs.playerctl}/bin/playerctl previous"
          "SUPER, 8, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          "SUPER, 9, exec, ${pkgs.playerctl}/bin/playerctl next"
        ];

        # Repeat when held
        bindle = [
          # Keyboard Media Keys
          "SUPER, equal, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          "SUPER, minus, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        bindm = [
          "ALT, mouse:272, movewindow"
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
}

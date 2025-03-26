{
  inputs,
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  home-manager.users.rafiq = {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      settings = {
        "$mainMonitor" = "desc:OOO AN-270W04K";
        "$vertMonitor" = "desc:Philips Consumer Electronics Company PHL 246V5 AU11330000086";
        "$mainMod" = "SUPER";
        "$terminal" = "kitty -1";
        "$multiplexer" = "$terminal -e zellij";
        "$browser" = "firefox";
        "$music" = "spotify";
        "$launcher" = "fuzzel";
        "$clipboard" = "$terminal --class clipse -e clipse";

        # Programs to run at startup
        exec-once = [
          "hyprlock"
          "clipse -listen"
          "hyprcloser"
        ];

        env = [
          "XCURSOR_SIZE,32"

          # Nvidia Settings
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct # needed for running vaapi-driver on later drivers"
        ];

        # Monitors
        monitor = [
          "$mainMonitor, 3840x2160@60, auto, auto"
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
          gaps_in = 0;
          gaps_out = 0;

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
          "$mainMod, return, exec, $multiplexer"
          "$mainMod, W, killactive"
          "$mainMod, O, exec, $browser"
          "$mainMod, Escape, exec, hyprlock"
          "$mainMod, Space, exec, $launcher"

          # Launch utilities
          "$mainMod_SHIFT, A, exec, hyprpicker -a"
          "$mainMod, V, exec, $clipboard"

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
        ];

        # Repeat when held
        bindle = [
          # Keyboard Media Keys
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
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

{
  config,
  lib,
  ...
}: {
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      env = [
        "XCURSOR_SIZE,32"

        # Nvidia Settings
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct # needed for running vaapi-driver on later drivers"
      ];

      # Monitors
      monitor = [
        "HDMI-A-2, 3840x2160@60, 0x0, 2.5"
        "DP-4, 1920x1080@60, -1280x0, 1.5"
        ", preferred, auto, 1"
      ];

      # Switching to the current workspace will switch to the previous
      binds.workspace_back_and_forth = true;
      cursor.default_monitor = "HDMI-A-2";

      # Windows
      general = {
        # Make there be no gaps in between windows or edges
        border_size = 5;
        gaps_in = 0;
        gaps_out = 0;

        resize_on_border = true;
      };

      # Programs
      exec-once = [
        "waybar"
      ];

      # Keybinds
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$music" = "spotify";

      bind = [
        "$mainMod, SEMICOLON, exec, $terminal"
        "$mainMod, W, killactive"
        "$mainMod, O, exec, $browser"
        "$mainMod, S, exec, $music"
        "$mainMod, M, exit"

        # HJKL to move between windows
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

        "$mainMod, V, togglefloating"
      ];

      bindm = [
        "ALT, mouse:272, movewindow"
      ];

      input = {
        numlock_by_default = true;
        follow_mouse = 2; # Click on a window to change focus
      };
    };
  };
}

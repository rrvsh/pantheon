{ config, lib, ... }: {
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

      input = {
	numlock_by_default = true;
	follow_mouse = 2; # Click on a window to change focus
      };

      # Keybinds
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "firefox";

      bind = [
	"$mainMod, Q, exec, $terminal"
	"$mainMod, W, killactive"
	"$mainMod, E, exec, $browser"
	"$mainMod, M, exit"

	"$mainMod, H, movefocus, l"
	"$mainMod, L, movefocus, r"

	"$mainMod_ALT, H, movewindow, l"
	"$mainMod_ALT, J, movewindow, d"
	"$mainMod_ALT, K, movewindow, u"
	"$mainMod_ALT, L, movewindow, r"

	"ALT_SHIFT, H, resizeactive, -10% 0"
	"ALT_SHIFT, J, resizeactive, 0 -10%"
	"ALT_SHIFT, K, resizeactive, 0 10%"
	"ALT_SHIFT, L, resizeactive, 10% 0"

	"$mainMod_CTRL, H, workspace, previous"
      ];
    };
  };
}

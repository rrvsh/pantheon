{ config, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      # Nvidia Settings
      env = [
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

      # Keybinds
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "firefox";

      bind = [
	"$mainMod, Q, exec, $terminal"
	"$mainMod, W, killactive"
	"$mainMod, E, exec, $browser"
	"$mainMod, M, exit"
      ];
    };
  };
  # xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/repos/dotfiles/users/rafiq/.config/hypr";
  # xdg.configFile."hypr/hyprland.conf".enable = false; # Needed so home-manager won't create the config file
}

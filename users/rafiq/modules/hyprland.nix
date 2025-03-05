{ config, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
  };
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/repos/dotfiles/users/rafiq/.config/hypr";
  xdg.configFile."hypr/hyprland.conf".enable = false; # Needed so home-manager won't create the config file
}

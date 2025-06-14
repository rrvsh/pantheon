{
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  wayland.windowManager.hyprland.settings = import ./hyprland/settings.nix {
    inherit pkgs osConfig lib;
  };
}

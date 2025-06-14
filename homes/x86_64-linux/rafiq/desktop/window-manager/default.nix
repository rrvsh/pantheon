{
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  wayland.windowManager.hyprland.settings = import ./_hyprland/settings.nix {
    inherit pkgs osConfig lib;
  };
}

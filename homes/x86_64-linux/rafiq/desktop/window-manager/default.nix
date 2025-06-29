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
  # TODO: add gamescope here or in nixos desktop module
}

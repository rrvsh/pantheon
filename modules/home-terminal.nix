{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty # default terminal emulator for hyprland
  ];
}

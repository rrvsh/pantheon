{ pkgs, inputs, ... }:
{
  imports = [
    ./programs/ags.nix
    ./programs/clipse.nix
    ./programs/dunst.nix
    ./programs/firefox.nix
    ./programs/fuzzel.nix
    ./programs/getty.nix
    ./programs/hyprland.nix
    ./programs/hyprlock.nix
    ./programs/hyprshade.nix
    ./programs/kitty.nix
    ./programs/spicetify.nix
    ./programs/stylix.nix
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
  ];

  home-manager.users.rafiq.home.packages = with pkgs; [
    hyprpicker
    inputs.hyprcloser.packages.${pkgs.stdenv.hostPlatform.system}.default
    wl-clipboard # provides cli copy and paste commands
  ];
}

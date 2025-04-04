{ pkgs, inputs, ... }:
with pkgs;
{
  imports = [
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
    ./programs/spotifyd.nix
    ./programs/stylix.nix
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
  ];

  environment.systemPackages = [
    wl-clipboard
  ];

  home-manager.users.rafiq.home.packages = [
    hyprpicker
    inputs.hyprcloser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

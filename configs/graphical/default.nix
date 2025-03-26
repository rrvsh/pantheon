{ pkgs, inputs, ... }:
{
  imports = [
    ./ags.nix
    ./clipse.nix
    ./dunst.nix
    ./firefox.nix
    ./fuzzel.nix
    ./getty.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprshade.nix
    ./kitty.nix
    ./spicetify.nix
  ];

  home-manager.users.rafiq.home.packages = with pkgs; [
    hyprpicker
    inputs.hyprcloser.packages.${pkgs.stdenv.hostPlatform.system}.default
    wl-clipboard # provides cli copy and paste commands
  ];
}

{ pkgs, ... }:
{
  persistDirs = [
    "docs"
    "repos"
    "vids"
    "tmp"
    ".cache/Smart Code ltd/Stremio"
    ".local/share/Smart Code ltd/Stremio"
  ];
  programs = {
    obs-studio.enable = true;
    vesktop.enable = true;
    thunderbird.enable = true;
    thunderbird.profiles.rafiq.isDefault = true;
  };
  home.packages = with pkgs; [ stremio ];
  stylix.image = ./wallpaper.png;
}

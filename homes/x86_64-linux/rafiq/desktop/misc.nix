{ pkgs, ... }:
{
  persistDirs = [
    "docs"
    "repos"
    "vids"
    "tmp"
  ];
  programs = {
    obs-studio.enable = true;
    thunderbird.enable = true;
    thunderbird.profiles.rafiq.isDefault = true;
  };
  home.packages = with pkgs; [
    stremio
  ];
}

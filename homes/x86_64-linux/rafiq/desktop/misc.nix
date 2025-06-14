{ pkgs, ... }:
{
  persistDirs = [
    "docs"
    "repos"
    "vids"
    "tmp"
    ".local/share/PrismLauncher"
  ];
  programs = {
    obs-studio.enable = true;
    thunderbird.enable = true;
    thunderbird.profiles.rafiq.isDefault = true;
  };
  home.packages = with pkgs; [
    stremio
    prismlauncher
  ];
}

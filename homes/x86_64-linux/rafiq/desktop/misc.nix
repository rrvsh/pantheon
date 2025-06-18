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
    vesktop = {
      enable = true;
      # https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts
      settings = { };
      # https://github.com/Vendicated/Vencord/blob/main/src/api/Settings.ts
      vencord.settings = { };
    };
    thunderbird.enable = true;
    thunderbird.profiles.rafiq.isDefault = true;
  };
  home.packages = with pkgs; [
    stremio
  ];
}

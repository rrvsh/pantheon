{
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (osConfig.desktop.media-player == "vlc") {
      home.packages = lib.singleton pkgs.vlc;
      home.file.".local/share/vlc/lua/extensions/vlc-play-next.lua".source = ./vlc-play-next.lua;
    })
    (lib.mkIf (osConfig.desktop.media-player == "mpv") {
      programs.mpv = {
        enable = true;
        package = pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            sponsorblock
          ];
          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
          };
        };
        config = {
          profile = "high-quality";
        };
      };
    })
  ];
}

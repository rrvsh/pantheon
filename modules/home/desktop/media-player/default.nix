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

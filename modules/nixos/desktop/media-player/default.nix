{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    singleton
    ;
  inherit (pkgs) vlc;
  cfg = config.desktop.media-player;
  addToHome = condition: attrs: mkIf condition { home-manager.sharedModules = singleton attrs; };
in
{
  options.desktop.media-player = {
    vlc.enable = mkEnableOption "";
  };

  config = mkMerge [
    (addToHome cfg.vlc.enable { home.packages = singleton vlc; })
  ];
}

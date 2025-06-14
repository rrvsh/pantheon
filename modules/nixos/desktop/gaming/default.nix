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
  cfg = config.desktop.gaming;
in
{
  options.desktop.gaming = {
    steam.enable = mkEnableOption "";
    prism-launcher.enable = mkEnableOption "";
  };

  config = mkMerge [
    (mkIf cfg.steam.enable {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      home-manager.sharedModules = singleton { persistDirs = singleton ".local/share/Steam"; };
    })
    (mkIf cfg.prism-launcher.enable {
      home-manager.sharedModules = singleton {
        home.packages = singleton pkgs.prismlauncher;
        persistDirs = singleton ".local/share/PrismLauncher";
      };
    })
  ];
}

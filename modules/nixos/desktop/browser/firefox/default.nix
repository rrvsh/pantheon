{ lib, config, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    singleton
    ;
  cfg = config.desktop.browser.firefox;
in
{
  options.desktop.browser.firefox.enable = mkEnableOption "";

  config = mkIf cfg.enable {
    home-manager.sharedModules = singleton {
      persistDirs = singleton ".mozilla/firefox";
      programs.firefox.enable = true;
      stylix.targets.firefox.colorTheme.enable = true;
    };
  };
}

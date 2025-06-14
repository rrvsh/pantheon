{ lib, config, ... }:
let
  inherit (lib)
    mkEnableOption
    optional
    singleton
    ;
  cfg = config.desktop.browser.firefox;
in
{
  options.desktop.browser.firefox.enable = mkEnableOption "";

  config.home-manager.sharedModules = optional cfg.enable {
    persistDirs = singleton ".mozilla/firefox";
    programs.firefox.enable = true;
    stylix.targets.firefox.colorTheme.enable = true;
  };
}

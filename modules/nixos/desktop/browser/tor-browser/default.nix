{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf singleton;
  cfg = config.desktop.browser.tor-browser;
in
{
  options.desktop.browser.tor-browser.enable = mkEnableOption "";

  config = mkIf cfg.enable {
    home-manager.sharedModules = singleton {
      persistDirs = singleton ".tor project";
      home.packages = singleton pkgs.tor-browser;
    };
  };
}

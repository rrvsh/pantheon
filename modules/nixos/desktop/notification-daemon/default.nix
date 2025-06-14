{ lib, config, ... }:
let
  inherit (lib) mkEnableOption singleton;
  cfg = config.desktop.notification-daemon;
in
{
  options.desktop.notification-daemon = {
    mako.enable = mkEnableOption "";
  };

  config.home-manager.sharedModules = singleton {
    services.mako.enable = cfg.mako.enable;
  };
}

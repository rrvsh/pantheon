{ lib, config, ... }:
let
  inherit (lib) singleton mkEnableOption;
  cfg = config.desktop.launcher;
in
{
  options.desktop.launcher = {
    fuzzel.enable = mkEnableOption "";
    wofi.enable = mkEnableOption "";
  };

  config.home-manager.sharedModules = singleton {
    programs.fuzzel.enable = cfg.fuzzel.enable;
    programs.wofi.enable = cfg.wofi.enable;
  };
}

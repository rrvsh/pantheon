{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption singleton optional;
  inherit (pkgs) kitty;
  cfg = config.desktop.terminal;
in
{
  options.desktop.terminal = {
    kitty.enable = mkEnableOption "";
    ghostty.enable = mkEnableOption "";
  };

  config = {
    home-manager.sharedModules = singleton {
      home.packages = optional cfg.kitty.enable kitty;
      programs.ghostty.enable = cfg.ghostty.enable;
    };
  };
}

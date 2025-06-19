{ config, lib, ... }:
let
  inherit (lib) singleton mkIf mkEnableOption;
  cfg = config.desktop.services.sunshine;
in
{
  options.desktop.services.sunshine = {
    enable = mkEnableOption "";
  };
  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        sunshine_name = config.hostname;
        origin_pin_allowed = "wan";
        origin_web_ui_allowed = "wan";
      };
      applications = { };
    };
    home-manager.sharedModules = singleton { persistDirs = singleton ".config/sunshine"; };
  };
}

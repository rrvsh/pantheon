{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) listOf str;
  inherit (lib.lists) allUnique;
  cfg = config.desktop.browser;
in
{
  options.desktop.browser = {
    firefox = {
      enable = mkEnableOption "";
      syncedProfiles = mkOption {
        type = listOf str;
        default = [ ];
      };
    };
  };

  config.assertions = [
    {
      assertion = allUnique cfg.firefox.syncedProfiles;
      message = "desktop.browser.firefox.syncedProfiles has duplicate elements.";
    }
  ];
}

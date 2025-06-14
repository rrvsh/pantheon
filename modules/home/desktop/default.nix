{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = config.desktop;
  upstreamCfg = osConfig.desktop;
  inherit (lib) mkMerge mkIf mkEnableOption;
in
{
  config = mkIf upstreamCfg.enable (mkMerge [
    (lib.mkIf (osConfig.hardware.gpu == "nvidia") {
    })
    (lib.mkIf osConfig.desktop.enableSpotifyd {
      services.spotifyd.enable = true;
      services.spotifyd.settings.global = {
        device_name = "${osConfig.system.hostname}";
        device_type = "computer";
        zeroconf_port = 5353;
      };
    })
    (lib.mkIf osConfig.desktop.enableSteam {
      home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
        ".local/share/Steam"
      ];
    })
    (lib.mkIf osConfig.desktop.enableSunshine {
      home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
        ".config/sunshine"
      ];
    })
  ]);
}

{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = config.desktop;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.desktop = {
    wayland.enableUtils = mkEnableOption "common Wayland utilities";
  };
  config = lib.mkMerge [
    (mkIf cfg.wayland.enableUtils {
      home.packages = with pkgs; [
        wl-clipboard-rs
      ];
    })
    (lib.mkIf (osConfig.hardware.gpu == "nvidia") {
      home.packages = [ pkgs.stable-diffusion-webui.forge.cuda ];
      home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
        ".local/share/stable-diffusion-webui"
      ];
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
  ];
}

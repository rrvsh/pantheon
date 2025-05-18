{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.desktop.windowManager == "hyprland") {
      environment.variables = {
	ELECTRON_OZONE_PLATFORM_HINT = "auto";
	NIXOS_OZONE_WL = "1";
      };
      programs.hyprland = {
        enable = true;
	withUWSM = true;
      };
    })
  ];
}

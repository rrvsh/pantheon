{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.desktop.windowManager == "hyprland") {
        environment.loginShellInit = # sh
          ''
            if [[ -z "$SSH_CLIENT" && -z "$SSH_CONNECTION" ]]; then
              if uwsm check may-start; then
                exec uwsm start hyprland-uwsm.desktop
              fi
            fi
          '';
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

{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf singleton;
  inherit (config.desktop) mainMonitor;
  cfg = config.desktop.window-manager.hyprland;
in
{
  options.desktop.window-manager.hyprland.enable = mkEnableOption "";

  config = mkIf cfg.enable {
    # Enable custom module for wayland utilities (clipboard etc.)
    desktop.enableWaylandUtilities = true;
    # Start Hyprland at boot only if not connecting through SSH
    environment.loginShellInit = # sh
      ''
        if [[ -z "$SSH_CLIENT" && -z "$SSH_CONNECTION" ]]; then
          if uwsm check may-start; then
            exec uwsm start hyprland-uwsm.desktop
          fi
        fi
      '';
    environment.variables = {
      # Get Electron apps to use Wayland
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
    };
    programs.hyprland = {
      enable = true;
      # Use UWSM to have each process controlled by systemd init
      withUWSM = true;
    };
    home-manager.sharedModules = singleton {
      wayland.windowManager.hyprland = {
        enable = true;
        # This is needed for UWSM
        systemd.enable = false;
        # Null the packages since we use them system wide
        package = null;
        portalPackage = null;
        settings.monitor = [ "${mainMonitor.id}, ${mainMonitor.resolution}@${mainMonitor.refresh-rate}, auto, ${mainMonitor.scale}" ];
      };
      xdg.configFile."uwsm/env".text = # sh
        ''
          # Force apps to scale right with Wayland
          export GDK_SCALE=${mainMonitor.scale}
          export STEAM_FORCE_DESKTOPUI_SCALING=${mainMonitor.scale}
        '';
      xdg.configFile."uwsm/env-hyprland".text = # sh
        ''
          export GDK_SCALE=${mainMonitor.scale}
          export STEAM_FORCE_DESKTOPUI_SCALING=${mainMonitor.scale}
        '';
    };
  };
}

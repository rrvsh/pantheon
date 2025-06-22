{
  config,
  lib,
  inputs,
  system,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf singleton;
  inherit (config.desktop) mainMonitor;
  cfg = config.desktop.window-manager.hyprland;
in
{
  options.desktop.window-manager.hyprland = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    desktop.enableWaylandUtilities = true;
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
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };
    home-manager.sharedModules = singleton {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        package = null;
        portalPackage = null;
      };
      xdg.configFile."uwsm/env".text = # sh
        ''
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

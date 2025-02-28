{ inputs, pkgs, ... }:

{
  # Define the Universal Wayland Session Manager.
  # This will start our compositor.
  # TODO: Eventually move this to a common desktop module.
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  programs.hyprland = {
    enable = true;
    # Use the packages that we have defined as inputs in our flake.
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    # Enable sustemd integration
    systemd.setPath.enable = true;
    withUWSM = true;
    # Enable compatibility with X11 apps
    xwayland.enable = true;
  };

  services.hypridle.enable = true;

  # Run a script that launches Hyprland through UWSM on login.
  services.hyprland-tty-launch.enable = true;
}

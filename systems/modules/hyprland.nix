{ inputs, pkgs, ... }: {
  programs.uwsm = {
    enable = false;
  };
  programs.hyprland = {
    enable = true;
    #withUWSN = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = with pkgs; [
    dunst
  ];
}

{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
  };
  security.pam.services.hyprlock = {};
}

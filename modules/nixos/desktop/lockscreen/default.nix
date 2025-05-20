{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.desktop.lockscreen == "hyprlock") {
      security.pam.services.hyprlock = { };
    })
  ];
}

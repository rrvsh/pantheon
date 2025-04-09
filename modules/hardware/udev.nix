{ pkgs, ... }:
{
  hardware.keyboard.qmk.enable = true;
  services.udev = {
    packages = with pkgs; [
      vial
      via
      qmk
      qmk-udev-rules
      qmk_hid
    ];
  };
}

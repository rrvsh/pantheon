{ lib, ... }:
{
  imports = [
    ./windowManager.nix
  ];

  options.desktop = {
    mainMonitor = {
      id = lib.pantheon.mkStrOption;
      scale = lib.pantheon.mkStrOption;
      resolution = lib.pantheon.mkStrOption;
      refresh-rate = lib.pantheon.mkStrOption;
    };
    windowManager = lib.pantheon.mkStrOption;
    lockscreen = lib.pantheon.mkStrOption;
  };
}

{ config, lib, ... }:
{
  imports = [
    ./windowManager.nix
  ];

  options.desktop = {
    windowManager = lib.pantheon.mkStrOption;
  };
}

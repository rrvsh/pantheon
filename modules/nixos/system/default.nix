{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
  ];

  options.system = {
    bootloader = lib.pantheon.mkStrOption;
  };
}

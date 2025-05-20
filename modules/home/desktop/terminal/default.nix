{ config, lib, pkgs, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.desktop.terminal == "kitty") {
      home.packages = with pkgs; [ kitty ];
      home.sessionVariables.TERMINAL = "kitty";
    })
  ];
}

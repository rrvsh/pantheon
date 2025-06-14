{ lib, pkgs, ... }:
let
  inherit (lib) singleton;
in
{
  home = {
    packages = singleton pkgs.fastfetch;
    sessionVariables.FETCH = "hyfetch";
    shellAliases.fetch = "hyfetch";
  };
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "bisexual";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.5;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "fastfetch";
    };
  };
}

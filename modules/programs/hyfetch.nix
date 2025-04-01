{ pkgs, ... }:
{
  home-manager.users.rafiq = {
    home.packages = [ pkgs.fastfetch ];
    home.shellAliases.fetch = "hyfetch";
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
  };
}

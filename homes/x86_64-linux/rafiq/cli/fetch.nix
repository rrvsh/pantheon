{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.fastfetch ];
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
        # Flag color alignment
        mode = "horizontal";
        fore_back = null;
      };
      backend = "fastfetch";
    };
  };
}

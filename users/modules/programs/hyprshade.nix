{ inputs, pkgs, ... }:
{
  home.packages = [ pkgs.hyprshade ];
  xdg.configFile."hypr/hyprshade.toml" = {
    enable = true;
    text = # toml
      ''
        [[shades]]
        name = "vibrance"
        default = true  # will be activated when no other shader is scheduled

        [[shades]]
        name = "blue-light-filter"
        start_time = 22:00:00
        end_time = 08:00:00   # optional if more than one shader has start_time
      '';
  };
  xdg.configFile."hypr/shaders" = {
    enable = true;
    recursive = true;
    source = "${inputs.hyprshaders}/shaders";
  };
}

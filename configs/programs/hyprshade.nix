{ inputs, pkgs, ... }:
{
  home-manager.users.rafiq = {
    home.packages = [ pkgs.hyprshade ];
    xdg.configFile."hypr/hyprshade.toml" = {
      enable = true;
      text = # toml
        ''
          [[shades]]
          name = "vibrance"
          default = true  # will be activated when no other shader is scheduled
        '';
    };
    xdg.configFile."hypr/shaders" = {
      enable = true;
      recursive = true;
      source = "${inputs.hyprshaders}/shaders";
    };
  };
}

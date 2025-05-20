{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (config.cli.fetch == "hyfetch") {
      home.packages = [ pkgs.fastfetch ];
      home.sessionVariables.FETCH = "hyfetch";
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

    })
  ];
}

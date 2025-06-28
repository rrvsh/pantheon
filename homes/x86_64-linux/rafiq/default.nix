{
  inputs,
  osConfig,
  lib,
  ...
}:
let
  inherit (lib) singleton optional;
  inherit (inputs) import-tree;
in
{
  imports =
    (optional osConfig.desktop.enable (import-tree ./desktop))
    ++ singleton (import-tree ./cli);

  config = {
    stylix.image = ./desktop/wallpaper.png;
  };
}

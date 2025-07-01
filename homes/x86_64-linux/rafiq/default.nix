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
    ++ singleton (import-tree ./cli)
    ++ [
      inputs.nix-index-database.hmModules.nix-index
      inputs.nvf.homeManagerModules.default
    ];

  config = {
    stylix.image = ./desktop/wallpaper.png;
  };
}

{
  pkgs,
  lib,
  inputs,
  system,
  osConfig,
  ...
}:
let
  inherit (lib) mkMerge;
in
mkMerge [
  (import ./browser.nix { inherit lib inputs system; })
  (import ./lockscreen.nix)
  (import ./launcher.nix)
  (import ./media-player.nix)
  (import ./status-bar.nix { inherit pkgs; })
  (import ./terminal.nix)
  (import ./window-manager { inherit pkgs osConfig lib; })
]

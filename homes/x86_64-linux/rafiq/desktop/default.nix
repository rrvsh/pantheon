{
  lib,
  inputs,
  system,
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
]

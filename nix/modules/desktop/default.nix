{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
in
{
  flake.modules.nixos.default.options.desktop.enable = mkEnableOption "";
}

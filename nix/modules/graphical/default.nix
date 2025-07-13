{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
in
{
  flake.modules = {
    nixos.graphical = {
      home-manager.sharedModules = [ { graphical = true; } ];
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
    };
    homeManager.default.options.graphical = mkEnableOption "";
    darwin.graphical.home-manager.sharedModules = [ { graphical = true; } ];
  };
}

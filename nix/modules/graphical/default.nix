{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
in
{
  flake.modules.nixos.graphical = {
    home-manager.sharedModules = [ { graphical = true; } ];
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
  flake.modules.homeManager.default.options.graphical = mkEnableOption "";
}

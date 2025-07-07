{ lib, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  flake.modules.nixos.default =
    { graphical, ... }:
    {
      config = mkIf graphical {
        home-manager.sharedModules = [ { graphical = true; } ];
        services.pipewire = {
          enable = true;
          pulse.enable = true;
        };
      };
    };
  flake.modules.homeManager.default.options.graphical = mkEnableOption "";
}

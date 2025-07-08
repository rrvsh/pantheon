{ config, inputs, ... }:
let
  inherit (config.flake.lib.services) mkWebApp;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    let
      cfg = config.server.web-apps.rrv-sh;
    in
    mkWebApp {
      inherit config;
      name = "rrv-sh";
      defaultPort = 2309;
      extraConfig.services.rrv-sh = {
        enable = true;
        inherit (cfg) port;
      };
    }
    // {
      imports = [ inputs.rrv-sh.nixosModules.default ];
    };
}

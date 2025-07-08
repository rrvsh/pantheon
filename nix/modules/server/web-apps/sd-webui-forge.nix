{
  lib,
  inputs,
  config,
  ...
}:
let
  inherit (lib.lists) singleton;
  inherit (config.flake.lib.services) mkWebApp;
in
{
  flake.modules.nixos.default =
    { config, ... }:
    let
      upstreamCfg = config.services.sd-webui-forge;
    in
    mkWebApp {
      inherit config;
      name = "sd-webui-forge";
      defaultPort = 7860;
      persistDirs = singleton {
        directory = upstreamCfg.dataDir;
        inherit (upstreamCfg) user group;
      };
      extraConfig.services.sd-webui-forge = {
        enable = true;
        listen = true;
        extraArgs = "--cuda-malloc";
      };
    }
    // {
      imports = [ inputs.stable-diffusion-webui-nix.nixosModules.default ];
    };
}

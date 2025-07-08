{
  lib,
  config,
  inputs,
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
      upstreamCfg = config.services.comfyUi;
    in
    mkWebApp {
      inherit config;
      name = "comfy-ui";
      defaultPort = 8188;
      persistDirs = singleton {
        directory = upstreamCfg.dataDir;
        inherit (upstreamCfg) user group;
        mode = "777";
      };
      extraConfig.services.comfyUi = {
        enable = true;
        listenHost = "0.0.0.0";
      };
    }
    // {
      imports = [ inputs.stable-diffusion-webui-nix.nixosModules.default ];
    };
}

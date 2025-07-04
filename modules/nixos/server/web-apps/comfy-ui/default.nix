{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) singleton;
  inherit (lib.pantheon.modules) mkWebApp;
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
  extraConfig = {
    assertions = singleton {
      assertion = config.machine.gpu.nvidia.enable;
      message = "You must run the comfy-ui service only with an nvidia gpu.";
    };
    services.comfyUi = {
      enable = true;
      listenHost = "0.0.0.0";
    };
  };
}
// {
  imports = [ inputs.stable-diffusion-webui-nix.nixosModules.default ];
}

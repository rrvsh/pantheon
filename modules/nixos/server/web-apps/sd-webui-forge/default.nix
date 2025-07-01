{
  config,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) singleton;
  inherit (lib.pantheon.modules) mkWebApp;
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
  extraConfig = {
    assertions = singleton {
      assertion = config.machine.gpu.nvidia.enable;
      message = "You must run the sd-webui-forge service only with an nvidia gpu.";
    };
    services.sd-webui-forge = {
      enable = true;
      listen = true;
      extraArgs = "--cuda-malloc";
    };
  };
}
// {
  imports = [ inputs.stable-diffusion-webui-nix.nixosModules.default ];
}

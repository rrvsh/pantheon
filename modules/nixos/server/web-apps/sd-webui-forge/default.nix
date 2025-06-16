{ config, lib, ... }:
let
  inherit (lib) singleton;
  inherit (lib.pantheon.modules) mkWebApp;
  cfg = config.server.web-apps.sd-webui-forge;
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
      assertion = config.hardware.gpu == "nvidia";
      message = "You must run the sd-webui-forge service only with an nvidia gpu.";
    };
    services.sd-webui-forge = {
      enable = true;
      listen = cfg.openFirewall;
      extraArgs = "--cuda-malloc";
    };
  };
}

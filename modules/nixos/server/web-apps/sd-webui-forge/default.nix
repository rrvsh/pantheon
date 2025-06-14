{ config, lib, ... }:
let
  inherit (lib) singleton mkEnableOption mkIf;
  cfg = config.server.sd-webui-forge;
  upstreamCfg = config.services.sd-webui-forge;
in
{
  options.server.sd-webui-forge = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    assertions = singleton {
      assertion = config.hardware.gpu == "nvidia";
      message = "You must run the sd-webui-forge service only with an nvidia gpu.";
    };
    persistDirs = singleton {
      directory = upstreamCfg.dataDir;
      inherit (upstreamCfg) user group;
    };
    services.sd-webui-forge = {
      enable = true;
      listen = true;
      extraArgs = "--cuda-malloc";
    };
  };
}

{ config, lib, ... }:
let
  cfg = config.server.reverse-proxy;
in
{
  options.server.reverse-proxy = {
    enable = lib.mkEnableOption "";
    type = lib.pantheon.mkStrOption;
    proxies = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (cfg.type == "nginx") {
        services.nginx = {
          enable = true;
        };
      })
    ]
  );
}

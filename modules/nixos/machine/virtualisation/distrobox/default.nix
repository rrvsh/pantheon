{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption singleton;
  cfg = config.machine.virtualisation.distrobox;
in
{
  options.machine.virtualisation.distrobox = {
    enable = mkEnableOption "";
  };
  config = mkIf cfg.enable {
    machine.virtualisation.podman.enable = true;
    home-manager.sharedModules = singleton {
      home.packages = singleton pkgs.distrobox;
      # persistDirs = [ ".local/share/containers" ];
    };
  };
}

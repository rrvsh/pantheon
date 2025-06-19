{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.machine.virtualisation.podman;
in
{
  options.machine.virtualisation.podman = {
    enable = mkEnableOption "";
  };
  config = mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    users.users."${config.mainUser.name}".extraGroups = [ "podman" ];
  };
}

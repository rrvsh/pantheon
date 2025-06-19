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
    users.users."${config.mainUser.name}" = {
      extraGroups = [ "podman" ];
      # https://wiki.nixos.org/wiki/Distrobox
      # subGidRanges = singleton {
      #   count = 65536;
      #   startGid = 1000;
      # };
      # subUidRanges = singleton {
      #   count = 65536;
      #   startUid = 1000;
      # };
    };
  };
}

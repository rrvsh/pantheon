{ config, lib, ... }:
let
  inherit (lib) mkDefault singleton;
in
{
  networking = {
    enableIPv6 = false;
    useDHCP = mkDefault true;
    hostName = config.hostname;
    networkmanager.enable = true;
  };

  services.openssh = {
    enable = true;
    settings.PrintMotd = true;
  };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."keys/tailscale".path;
  };
  persistDirs = singleton "/var/lib/tailscale";
}

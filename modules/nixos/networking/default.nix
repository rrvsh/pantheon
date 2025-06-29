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
    authKeyFile = config.sops.secrets."tailscale/client-secret".path;
    authKeyParameters.preauthorized = true;
  };
  persistDirs = singleton "/var/lib/tailscale";
}

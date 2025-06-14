{ config, lib, ... }:
let
  inherit (lib) singleton;
in
{
  config = {
    networking = {
      enableIPv6 = false;
      useDHCP = lib.mkDefault true;
      hostName = config.system.hostname;
      networkmanager.enable = true;
    };

    services.openssh = {
      enable = true;
      settings = {
        PrintMotd = true;
      };
    };

    services.tailscale = {
      enable = true;
      authKeyFile = config.sops.secrets."keys/tailscale".path;
    };
    persistDirs = singleton "/var/lib/tailscale";
  };
}

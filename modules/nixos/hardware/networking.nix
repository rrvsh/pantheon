{ config, lib, ... }:
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
    environment.persistence."/persist".directories = [ "/var/lib/tailscale" ];
  };
}

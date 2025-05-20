{ config, lib, ... }:
{
  config = lib.mkMerge [
    {
      networking.useDHCP = lib.mkDefault true;
      networking.hostName = config.system.hostname;
      networking.networkmanager.enable = true;

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
      environment.persistence."/persist".files = [ "/var/lib/tailscale/tailscaled.state" ];
    }

  ];
}

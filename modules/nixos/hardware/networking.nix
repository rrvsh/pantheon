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
      environment.persistence."/persist".directories = [ "/var/lib/tailscale" ];
    }
    (lib.mkIf config.desktop.enableSpotifyd {
      networking.firewall.allowedTCPPorts = [ 5353 ];
      networking.firewall.allowedUDPPorts = [ 5353 ];
    })
  ];
}

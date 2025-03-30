{
  hostname,
  lib,
  config,
  ...
}:
{
  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";

    # Configures a simple stateful firewall.
    # By default, it doesn't allow any incoming connections.
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
      ];
      allowedUDPPorts = [ ];
    };

    interfaces.enp12s0.wakeOnLan.policy = [
      "phy"
      "unicast"
      "multicast"
      "broadcast"
      "arp"
      "magic"
      "secureon"
    ];
    interfaces.enp12s0.wakeOnLan.enable = true;
  };
  services.openssh.enable = true;
  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets.ts_auth_key.path;
  };
}

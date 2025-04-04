{ hostname, ... }:
{
  home-manager.users.rafiq.services.spotifyd = {
    enable = true;
    settings = {
      global = {
        device_name = "${hostname}";
        device_type = "computer";
        zeroconf_port = 5353;
      };
    };
  };
}

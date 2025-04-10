{ config, ... }:
{
  services.wakapi = {
    enable = true;
    passwordSaltFile = config.sops.secrets."services/wakapi_password_salt".path;
    settings = {
      server = {
        listen_ipv4 = "0.0.0.0";
        listen_ipv6 = "-";
        port = 3000;
      };
    };
  };
}

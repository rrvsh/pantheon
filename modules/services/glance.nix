{
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      server.host = "0.0.0.0";
      server.port = 8080;
    };
  };
}

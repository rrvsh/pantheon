{
  services.nginx = {
    enable = true;
    defaultListen = [
      {
        addr = "0.0.0.0";
        port = 18080;
      }
    ];
    virtualHosts = {
      localhost = {
        locations."/" = {
          return = "200 '<html><body>It works</body></html>'";
          extraConfig = ''
            default_type text/html;
          '';
        };
      };
    };
  };
}

let
  glancePort = 8080;
  homeColumn = {
    size = "full";
    widgets = [
      {
        title = "Services";
        type = "monitor";
        cache = "1m";
        sites = [
          # https://simpleicons.org/
          {
            title = "Gitea";
            icon = "si:gitea";
            url = "https://gitea.bwfiq.com";
          }
          {
            title = "LibreChat";
            icon = "si:googlechat";
            url = "https://chat.bwfiq.com";
          }
        ];
      }
      {
        title = "Feed";
        type = "rss";
        style = "detailed-list";
        feeds = [
          {
            title = "selfh.st";
            url = "https://selfh.st/rss/";
          }
        ];
      }
    ];
  };
in
{
  home-manager.users.rafiq.services.glance = {
    enable = true;
    settings.server = {
      host = "0.0.0.0";
      port = glancePort;
    };
    settings.pages = [
      {
        name = "Home";
        columns = [
          homeColumn
        ];
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [ glancePort ];
}

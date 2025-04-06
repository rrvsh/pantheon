let
  glancePort = 8080;
  newsFeedColumn = {
    size = "full";
    widgets = [
      {
        title = "Feed";
        type = "rss";
        style = "detailed-list";
        feeds = [
          {
            title = "Bloomberg";
            url = "https://feeds.bloomberg.com/markets/news.rss";
          }
          {
            title = "Fox Business";
            url = "https://moxie.foxbusiness.com/google-publisher/markets.xml";
          }
        ];
      }
    ];
  };
  serviceMonitoringColumn = {
    size = "small";
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
          serviceMonitoringColumn
          newsFeedColumn
        ];
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [ glancePort ];
}

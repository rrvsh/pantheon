{
  config,
  lib,
  ...
}:
let
  moduleName = "service-glance";
  cfg = config."${moduleName}";

  glancePort = 1227;
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
        title = "Newsletters";
        type = "rss";
        style = "detailed-list";
        limit = 100000;
        feeds = [
          {
            title = "selfh.st";
            url = "https://selfh.st/rss/";
          }
          {
            title = "This Week in Rust";
            url = "https://this-week-in-rust.org/rss.xml";
          }
        ];
      }
      {
        title = "Blogs";
        type = "rss";
        style = "detailed-list";
        limit = 100000;
        feeds = [
          {
            title = "Makefile.feld";
            url = "https://blog.feld.me/feeds/all.atom.xml";
          }
          {
            title = "Xe Iaso";
            url = "https://xeiaso.net/blog.rss";
          }
          {
            title = "Alex Haydock";
            url = "https://blog.infected.systems/posts/index.xml";
          }
          {
            title = "journix.dev";
            url = "https://journix.dev/feed.xml";
          }
          {
            title = "Venam's Blog";
            url = "https://venam.net/blog/feed.xml";
          }
        ];
      }
    ];
  };
in
{
  options = {
    "${moduleName}" = {
      enable = lib.mkEnableOption "Enable ${moduleName}.";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        networking.firewall.allowedTCPPorts = [ glancePort ];
        services.glance = {
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
      }
    ]
  );
}

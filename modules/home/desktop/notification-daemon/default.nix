{ osConfig, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (osConfig.desktop.notification-daemon == "mako") {
      home.sessionVariables.NOTIFICATION_DAEMON = "mako";
      services.mako = {
        enable = true;
        settings = {
          default-timeout = 10000;
        };
      };
    })
  ];
}

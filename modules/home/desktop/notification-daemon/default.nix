{ config, lib, ... }:
{
  config = lib.mkMerge [
    (lib.mkIf (config.desktop.notification-daemon == "mako") {
      home.sessionVariables.NOTIFICATION_DAEMON = "mako";
      services.mako = {
        enable = true;
        settings = { };
      };
    })
  ];
}

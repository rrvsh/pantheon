{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  options.desktop = {
    windowManager = lib.pantheon.mkStrOption;
    lockscreen = lib.pantheon.mkStrOption;
    browser = lib.pantheon.mkStrOption;
    terminal = lib.pantheon.mkStrOption;
    notification-daemon = lib.pantheon.mkStrOption;
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = (osConfig.desktop.windowManager == config.desktop.windowManager);
          message = "You have set your home window manager to one that is not installed on this system.";
        }
      ];
    }
    (lib.mkIf (osConfig.hardware.gpu == "nvidia") {
      home.packages = [ pkgs.stable-diffusion-webui.forge.cuda ];
      home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
        ".local/share/stable-diffusion-webui"
      ];
    })
  ];
}

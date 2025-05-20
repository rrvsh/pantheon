{
  config,
  lib,
  osConfig,
  ...
}:
{
  options.desktop = {
    windowManager = lib.pantheon.mkStrOption;
    browser = lib.pantheon.mkStrOption;
    terminal = lib.pantheon.mkStrOption;
  };

  config = {
    assertions = [
      {
        assertion = (osConfig.desktop.windowManager == config.desktop.windowManager);
        message = "You have set your home window manager to one that is not installed on this system.";
      }
    ];
  };
}

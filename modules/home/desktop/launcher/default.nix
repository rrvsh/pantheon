{
  config,
  lib,
  osConfig,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (osConfig.desktop.launcher == "fuzzel") {
      home.sessionVariables.LAUNCHER = "fuzzel";
      programs.fuzzel = {
        enable = true;
      };
    })
    (lib.mkIf (osConfig.desktop.launcher == "wofi") {
      home.sessionVariables.LAUNCHER = "wofi";
      programs.wofi = {
        enable = true;
        style = null;
        settings = { };
      };
    })
  ];
}

{
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (osConfig.desktop.terminal == "kitty") {
      home.packages = with pkgs; [ kitty ];
      home.sessionVariables.TERMINAL = "kitty";
    })
    (lib.mkIf (osConfig.desktop.terminal == "ghostty") {
      home.sessionVariables.TERMINAL = "ghostty -e";
      programs.ghostty = {
        enable = true;
        settings = {
          confirm-close-surface = false;
        };
      };
    })
  ];
}

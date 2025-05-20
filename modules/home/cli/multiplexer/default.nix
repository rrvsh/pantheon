{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.multiplexer == "zellij") {
    home.sessionVariables.MULTIPLEXER = "zellij";
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      attachExistingSession = true;
      exitShellOnExit = true;
      settings = {
        default_layout = "compact";
        pane_frames = false;
        show_startup_tips = false;
        show_release_notes = false;
      };
    };
  };
}

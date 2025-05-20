{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.multiplexer == "zellij") {
    home.sessionVariables.multiplexer = "zellij -c";
    programs.zellij = {
      enable = true;
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

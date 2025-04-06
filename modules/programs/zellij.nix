{
  home-manager.users.rafiq.programs.zellij = {
    enable = true;
    attachExistingSession = true;
    settings = {
      show_startup_tips = false;
      pane_frames = false;
      keybinds.unbind = [
        "Ctrl h"
      ];
    };
  };
}

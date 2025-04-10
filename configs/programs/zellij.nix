{
  home-manager.users.rafiq = {
    programs.zellij = {
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
    xdg.configFile."zellij/layouts/default.kdl".text = # kdl
      ''
        layout {
          pane
          pane size=1 borderless=true {
            plugin location="tab-bar"
          }
          pane size=1 borderless=true {
            plugin location="status-bar"
          }
        }
      '';
  };
}

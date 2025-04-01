{
  home-manager.users.rafiq = {
    programs.zellij = {
      enable = true;
      settings = {
        show_startup_tips = false;
        keybinds.unbind = [
          "Ctrl h"
        ];
      };
    };
    home.sessionVariables.ZELLIJ_AUTO_ATTACH = "true";
  };
}

{
  home-manager.users.rafiq = {
    programs.zellij = {
      enable = true;
      settings = {
        mouse_mode = false;
        keybinds.unbind = [
          "Ctrl h"
        ];
      };
    };
    home.sessionVariables.ZELLIJ_AUTO_ATTACH = "true";
  };
}

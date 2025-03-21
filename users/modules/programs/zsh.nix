{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    dirHashes = {
      repos = "$HOME/GitRepos";
      dl = "$HOME/Downloads";
    };
    initContent = # zsh
      ''
        # Bind CTRL+Backspace to delete whole word
        bindkey '^H' backward-kill-word
      '';
    # TODO: Look into whether we need to add the history attribute
    profileExtra = # bash
      ''
              if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
            dbus-run-session Hyprland
        fi
      '';
  };
}

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    # TODO: Look into whether we need to add the history attribute
    profileExtra = # bash
      ''
              if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
            dbus-run-session Hyprland
        fi
      '';
  };
}

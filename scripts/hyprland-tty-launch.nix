{ config, lib, ... }:

{
  options.services.hyprland-tty-launch.enable = lib.mkEnableOption "Enable launching Hyprland from TTY with UWSM";

  config = lib.mkIf config.services.hyprland-tty-launch.enable {
    environment.etc."profile.d/hyprland-tty-launch.sh".text = ''
      #!/bin/$SHELL

      # if uwsm check may-start && uwsm select; then
      #   exec systemd-cat -t uwsm_start uwsm start default
      # fi

      # OR (to bypass the compositor selection menu):
      if uwsm check may-start; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };
}

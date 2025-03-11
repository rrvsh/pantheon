{ pkgs, ... }: {
    # Terminal Multiplexing
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin

        # Session Management between Reboots
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ];
      extraConfig = ''
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",tmux-256color:RGB"
	set -as terminal-features ",tmux-256color:RGB"
        
        # inherit environment variables from outside so that we can use wl-copy etc
        setenv -g WAYLAND_DISPLAY "$WAYLAND_DISPLAY"
setenv -g XDG_RUNTIME_DIR "$XDG_RUNTIME_DIR"
      '';
    };
}

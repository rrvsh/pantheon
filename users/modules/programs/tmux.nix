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
        set -ag terminal-overrides ",xterm-256color:RGB"
      '';
    };
}

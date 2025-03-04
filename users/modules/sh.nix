{pkgs, ...}: {
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake";
        gs = "git status";
        ai = "aichat -r %shell% -e";
      };
    };

    # direnv lets us declare a .envrc in each project directory
    # and updates the shell with the packages specified.
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    # starship is a customisable prompt for any shell
    starship = {
      enable = true;
      enableBashIntegration = true;
    };

    # Terminal Multiplexing
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin

        # Keybind Hints
        tmux-which-key

        # Status Line Decoration
        tmux-powerline

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
  };
}

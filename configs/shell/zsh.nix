{
  pkgs,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
  };
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ]; # enables completion
  home-manager.users.rafiq = {
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

          export CWP_JIRA_LINK_FILE="${config.sops.secrets.cwp_jira_link.path}"
          export CWP_JIRA_PAT_FILE="${config.sops.secrets.cwp_jira_pat.path}"
        '';
      # TODO: Look into whether we need to add the history attribute
      profileExtra = # bash
        ''
                if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
              dbus-run-session Hyprland
          fi
        '';
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
    };
  };
}

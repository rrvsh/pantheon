{ pkgs, config, ... }:
{
  imports = [
    ./programs/scripts
    ./programs/aichat.nix
    ./programs/comma.nix
    ./programs/direnv.nix
    ./programs/editorconfig.nix
    ./programs/git.nix
    ./programs/hyfetch.nix
    ./programs/nh.nix
    ./programs/nvf.nix
    ./programs/starship.nix
    ./programs/tealdeer.nix
    ./programs/yazi.nix
    ./programs/zellij.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  environment.shellInit = # sh
    ''
      export CWP_JIRA_LINK=$(sudo cat ${config.sops.secrets.cwp_jira_link.path})
      export CWP_JIRA_PAT=$(sudo cat ${config.sops.secrets.cwp_jira_pat.path})
      export GEMINI_API_KEY=$(sudo cat ${config.sops.secrets.gemini_api_key.path})
    '';

  home-manager.users.rafiq.home = {
    shell.enableShellIntegration = true;
    shellAliases = {
      cd = "z";
      v = "$EDITOR";
      l = "eza -1lah --git --time-style '+%Y-%m-%d %H:%M'";
      # Thanks to https://www.reddit.com/r/NixOS/comments/fsummx/comment/fm3jbcm/!
      list-all-packages = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
    };

    packages = with pkgs; [
      devenv
      eza
    ];
  };
}

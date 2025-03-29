{ pkgs, config, ... }:
{
  imports = [
    ./scripts
    ./aichat.nix
    ./comma.nix
    ./direnv.nix
    ./editorconfig.nix
    ./fzf.nix
    ./git.nix
    ./nh.nix
    ./nvf.nix
    ./starship.nix
    ./tealdeer.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
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
      gs = "git status";
      cd = "z";
      v = "$EDITOR";
      g = "git";
      l = "eza -1lah --git --time-style '+%Y-%m-%d %H:%M'";
      list-all-packages = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
    };

    packages = with pkgs; [
      bat
      btop # add settings as home-manager module
      devenv
      fastfetch
      ripgrep
      ttyper
      eza
    ];
  };
}

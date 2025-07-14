{ config, ... }:
let
  cfg = config.flake;
in
{
  flake.modules.darwin.graphical.homebrew = {
    enable = true;
    user = cfg.admin.username;
    onActivation.cleanup = "uninstall";
    brews = [
      "mise"
      "docker"
    ];
    casks = [
      "ghostty"
      "slack"
      "gitify"
      "telegram"
    ];
  };
  flake.modules.homeManager.rafiq = {
    # make sure brew is on the path for M1
    programs.zsh.initContent = ''
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
    programs.fish.shellInit = ''
      if test (uname -m) = "arm64"
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };
}

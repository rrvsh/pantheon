{
  flake.modules.darwin.graphical.homebrew = {
    brews = [
      "mise"
      "docker"
      "docker-compose"
      "docker-buildx"
    ];
    casks = [
      "bambu-studio"
      "ghostty"
      "linear-linear"
      "mixxx"
      "slack"
      "spotify"
      "steam"
      "telegram"
      "vial"
      "whatsapp"
    ];
  };
  flake.modules.homeManager.rafiq = {
    home.file.".docker/config.json".text = ''
      {
        "cliPluginsExtraDirs": [
         "$HOMEBREW_PREFIX/lib/docker/cli-plugins"
        ]
      }
    '';
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

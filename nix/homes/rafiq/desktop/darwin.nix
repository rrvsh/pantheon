{ lib, ... }:
let
  inherit (lib.modules) mkIf;
in
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
  flake.modules.homeManager.rafiq =
    { pkgs, config, ... }:
    mkIf (config.graphical && pkgs.stdenv.isDarwin) {
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

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
      "moonlight"
      "obs"
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
      services.skhd = {
        enable = true;
        config = ''
          cmd - escape : if osascript -e 'tell application "System Events" to exists (process "ghostty")'; \
                           osascript -e 'tell application "ghostty" to activate'; \
                         else; \
                           ghostty; \
                         end
          cmd - o : if osascript -e 'tell application "System Events" to exists (process "Firefox")'; \
                      osascript -e 'tell application "Firefox" to activate'; \
                    else; \
                      open -a /Users/Rafiq/Applications/Home\ Manager\ Apps/Firefox.app; \
                    end
        '';
      };
    };
}

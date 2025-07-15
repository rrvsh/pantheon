{ config, ... }:
let
  inherit (config.manifest) users;
in
{
  flake.modules.homeManager.default =
    { config, ... }:
    {
      home.sessionVariables.GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
      programs.git = {
        enable = true;
        userName = users.${config.home.username}.name;
        userEmail = users.${config.home.username}.email;
        signing.key = "~/.ssh/id_ed25519.pub";
      };
    };
}

{
  flake.modules.homeManager.default =
    { manifest, config, ... }:
    {
      home.sessionVariables.GIT_CONFIG_GLOBAL = "$HOME/.config/git/config";
      programs.git = {
        userName = manifest.users.${config.home.username}.name;
        userEmail = manifest.users.${config.home.username}.email;
        signing.key = "~/.ssh/id_ed25519.pub";
      };
    };
}

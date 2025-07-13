{
  flake.modules.darwin.graphical.homebrew =
    { config, ... }:
    {
      enable = true;
      primaryUser = config.home.username;
      onActivation.cleanup = "uninstall";
      casks = [ "ghostty" ];
    };
}

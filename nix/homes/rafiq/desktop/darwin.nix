{
  flake.modules.darwin.graphical.homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    casks = [ "ghostty" ];
  };
}

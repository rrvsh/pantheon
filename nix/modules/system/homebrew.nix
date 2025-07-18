{ config, ... }:
let
  inherit (config.manifest) admin;
in
{
  flake.modules.darwin.graphical.homebrew = {
    enable = true;
    user = admin.username;
    onActivation.cleanup = "uninstall";
  };
}

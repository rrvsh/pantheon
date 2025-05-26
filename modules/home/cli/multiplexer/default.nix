{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkMerge [
    (lib.mkIf (config.cli.multiplexer == "zellij") (
      import ./zellij.nix { inherit config pkgs osConfig; }
    ))
  ];
}

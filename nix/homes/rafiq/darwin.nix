{ lib, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  flake.modules.homeManager.rafiq =
    {
      pkgs,
      config,
      hostName,
      hostConfig,
      ...
    }:
    mkIf (pkgs.system == "aarch64-darwin" || pkgs.system == "x86_64-darwin") {
      home.file."Library/Application Support/aichat/config.yaml".text = ''
        model: gemini:gemini-2.0-flash
        clients:
        - type: gemini
      '';
    };
}

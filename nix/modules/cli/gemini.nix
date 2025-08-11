{ lib, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  flake.modules.homeManager.default =
    { config, pkgs, ... }:
    let
      cfg = config.programs.gemini-cli;
    in
    {
      options.programs.gemini-cli = {
        enable = mkEnableOption "the Gemini CLI app";
      };
      config = mkIf cfg.enable { home.packages = [ pkgs.gemini-cli ]; };
    };
}

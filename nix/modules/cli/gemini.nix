{ lib, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption mkPackageOption;
in
{
  flake.modules.homeManager.default =
    { config, pkgs, ... }:
    let
      cfg = config.programs.gemini-cli;
      jsonFormat = pkgs.formats.json { };
    in
    {
      options.programs.gemini-cli = {
        enable = mkEnableOption "the Gemini CLI app";
        package = mkPackageOption pkgs "gemini-cli" { };
        settings = mkOption {
          type = jsonFormat.type;
          default = { };
          example = lib.literalExpression ''
            {
              "theme": "Default",
              "vimMode": true,
              "preferredEditor": "nvim",
              "autoAccept": true
            }
          '';
          description = "JSON config for the Gemini CLI";
        };
      };
      config = mkIf cfg.enable {
        home.packages = [ cfg.package ];
        home.file.".gemini/settings.json" = lib.mkIf (cfg.settings != { }) {
          source = jsonFormat.generate "gemini-settings.json" cfg.settings;
        };
      };
    };
}

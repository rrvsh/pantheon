{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.editor == "nvf") {
    home.sessionVariables.EDITOR = "nvim";
    programs.nvf = {
      enable = true;
      settings.vim = {
        autocomplete = import ./autocomplete.nix;
        keymaps = import ./keymaps.nix;
        languages = import ./languages.nix;
        lsp = import ./lsp.nix;
        options = import ./options.nix;
        utility = import ./utility.nix;
        visuals = import ./visuals.nix;
      };
    };
  };
}

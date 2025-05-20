{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.editor == "nvf") {
    home.sessionVariables.EDITOR = "nvim";
    programs.nvf = {
      enable = true;
      settings.vim = {
        options = import ./options.nix;
        keymaps = import ./keymaps.nix;
        lsp = import ./lsp.nix;
        languages = import ./languages.nix;
        autocomplete = import ./autocomplete.nix;
        utility = import ./utility.nix;
      };
    };
  };
}

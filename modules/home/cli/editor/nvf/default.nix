{ config, lib, ... }:
{
  config = lib.mkIf (config.cli.editor == "nvf") {
    home.sessionVariables.EDITOR = "nvim";
    home.persistence."/persist/home/${config.snowfallorg.user.name}".directories = [
      ".local/share/nvf"
    ];
    programs.nvf = {
      enable = true;
      settings.vim = {
        hideSearchHighlight = true;
        syntaxHighlighting = true;
        telescope.enable = true;
        searchCase = "ignore";
        undoFile.enable = true;
        fzf-lua.enable = true;
        git.enable = true;
        git.gitsigns.enable = false;
        autocomplete = import ./autocomplete.nix { inherit lib; };
        autopairs.nvim-autopairs.enable = true;
        binds = import ./binds.nix;
        clipboard = import ./clipboard.nix;
        diagnostics = import ./diagnostics.nix;
        keymaps = import ./keymaps.nix;
        languages = import ./languages.nix;
        lsp = import ./lsp.nix;
        navigation = import ./navigation.nix;
        notes = import ./notes.nix;
        options = import ./options.nix;
        notify = import ./notify.nix;
        snippets = import ./snippets.nix;
        statusline = import ./statusline.nix;
        treesitter = import ./treesitter.nix;
        ui = import ./ui.nix;
        utility = import ./utility.nix;
        visuals = import ./visuals.nix;
      };
    };
  };
}

{ lib, pkgs, ... }:
let
  inherit (lib) singleton;
in
{
  home.sessionVariables.EDITOR = "nvim";
  persistDirs = singleton ".local/share/nvf";
  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    hideSearchHighlight = true;
    syntaxHighlighting = true;
    telescope.enable = true;
    searchCase = "ignore";
    fzf-lua.enable = true;
    git.enable = true;
    undoFile.enable = true;
    autopairs.nvim-autopairs.enable = true;
    autocomplete = import ./_nvf/autocomplete.nix { inherit lib; };
    binds = import ./_nvf/binds.nix;
    keymaps = import ./_nvf/keymaps.nix;
    languages = import ./_nvf/languages.nix;
    lsp = import ./_nvf/lsp.nix;
    navigation = import ./_nvf/navigation.nix;
    notes = import ./_nvf/notes.nix;
    options = import ./_nvf/options.nix;
    snippets = import ./_nvf/snippets.nix { inherit pkgs; };
    statusline = import ./_nvf/statusline.nix;
    treesitter = import ./_nvf/treesitter.nix;
    ui = import ./_nvf/ui.nix;
    utility = import ./_nvf/utility.nix;
    visuals = import ./_nvf/visuals.nix;
  };
}

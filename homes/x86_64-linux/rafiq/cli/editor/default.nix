{ lib, pkgs, ... }:
let
  inherit (lib) singleton;
in
{
  home.sessionVariables.EDITOR = "nvim";
  persistDirs = singleton ".local/share/nvf";
  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    startPlugins = [ pkgs.pantheon.snippets ];
    hideSearchHighlight = true;
    syntaxHighlighting = true;
    telescope.enable = true;
    searchCase = "ignore";
    undoFile.enable = true;
    fzf-lua.enable = true;
    git.enable = true;
    git.gitsigns.enable = false;
    autopairs.nvim-autopairs.enable = true;
    autocomplete = import ./_nvf/autocomplete.nix { inherit lib; };
    binds = import ./_nvf/binds.nix;
    clipboard = import ./_nvf/clipboard.nix;
    diagnostics = import ./_nvf/diagnostics.nix;
    keymaps = import ./_nvf/keymaps.nix;
    languages = import ./_nvf/languages.nix;
    lsp = import ./_nvf/lsp.nix;
    navigation = import ./_nvf/navigation.nix;
    notes = import ./_nvf/notes.nix;
    options = import ./_nvf/options.nix;
    notify = import ./_nvf/notify.nix;
    snippets = import ./_nvf/snippets.nix { inherit pkgs; };
    statusline = import ./_nvf/statusline.nix;
    treesitter = import ./_nvf/treesitter.nix;
    ui = import ./_nvf/ui.nix;
    utility = import ./_nvf/utility.nix;
    visuals = import ./_nvf/visuals.nix;
  };
}

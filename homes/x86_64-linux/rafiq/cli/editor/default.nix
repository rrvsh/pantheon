{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.nvf.homeManagerModules.default ];
  home.sessionVariables.EDITOR = "nvim";
  programs.nvf.enable = true;
  programs.nvf.settings.vim = {
    syntaxHighlighting = true;
    hideSearchHighlight = true;
    searchCase = "ignore";
    undoFile.enable = true;
    telescope.enable = true;
    fzf-lua.enable = true;
    git.enable = true;
    autopairs.nvim-autopairs.enable = true;
    autocomplete = import ./_nvf/autocomplete.nix { inherit lib; };
    binds = import ./_nvf/binds.nix;
    languages = import ./_nvf/languages.nix;
    lsp = import ./_nvf/lsp.nix;
    navigation = import ./_nvf/navigation.nix;
    notes.todo-comments.enable = true;
    options = {
      autoindent = true;
      backspace = "indent,eol,start";
      cursorline = true;
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;
    };
    snippets = import ./_nvf/snippets.nix { inherit pkgs; };
    statusline = import ./_nvf/statusline.nix;
    treesitter = {
      autotagHtml = true;
      fold = true;
      indent.disable = [ "markdown" ];
      textobjects.enable = true;
    };
    ui = import ./_nvf/ui.nix;
    utility = import ./_nvf/utility.nix;
    visuals = import ./_nvf/visuals.nix;
  };
}

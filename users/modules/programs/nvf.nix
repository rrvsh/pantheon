{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf/options.nix
    ./nvf/keymaps.nix
    ./nvf/lsp.nix
    ./nvf/debugger.nix
    ./nvf/languages.nix
    ./nvf/visual.nix
    ./nvf/input.nix
    ./nvf/filetree.nix
    ./nvf/search.nix
    ./nvf/utilities.nix
    ./nvf/notes.nix
  ];
  home.sessionVariables.EDITOR = "nvim";
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      spellcheck.enable = true;
    };
  };
}

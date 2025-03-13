{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf/debugger.nix
    ./nvf/filetree.nix
    ./nvf/input.nix
    ./nvf/keymaps.nix
    ./nvf/languages.nix
    ./nvf/lsp.nix
    ./nvf/notes.nix
    ./nvf/options.nix
    ./nvf/search.nix
    ./nvf/utilities.nix
    ./nvf/visual.nix
  ];
  home.sessionVariables.EDITOR = "nvim";
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
    };
  };
}

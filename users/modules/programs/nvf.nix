{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf/input.nix
    ./nvf/languages.nix
    ./nvf/ui.nix
    ./nvf/utilities.nix
  ];
  home.sessionVariables.EDITOR = "nvim";
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      options = {
        # Indentation
        autoindent = true;
        smartindent = true;
        expandtab = true;
        smarttab = true;
        wrap = true;
        shiftwidth = 2;
        tabstop = 2;
        foldlevel = 1000; # Open all folds by default

        # Search
        hlsearch = true;
        ignorecase = true;
        incsearch = true;
        smartcase = true; # case-sensitive if search contains uppercase

        # Visual
        number = true;
        cursorline = true;
        visualbell = true;
        termguicolors = true;

        # Input
        backspace = "indent,eol,start";
      };
      keymaps = [
        {
          key = "gf";
          mode = "n";
          action = ":cd %:p:h<CR>:e <cfile><CR>";
          silent = true;
        }
      ];
    };
  };
}

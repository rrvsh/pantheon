{
  programs.nvf.settings.vim = {
    options = {
      # Indentation
      autoindent = true;
      smartindent = true;
      expandtab = true;
      smarttab = true;
      wrap = false;
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
      relativenumber = true;
      cursorline = true;
      visualbell = true;
      termguicolors = true;

      # Input
      backspace = "indent,eol,start";
    };
  };
}

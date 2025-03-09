{ inputs, ... }: {
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
    ./nixvim/nvim-tree.nix # filetree
    ./nixvim/noice.nix # custom CMDLINE
    ./nixvim/lualine.nix # custom statusline
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    opts = {
      # Indentation
      autoindent = true;
      smartindent = true;
      expandtab = true;
      smarttab = true;
      wrap = false;
      shiftwidth = 2;
      tabstop = 2;

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

    clipboard.providers.wl-copy.enable = true;
  };
}

{ inputs, ... }: {
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
    ./nixvim/lualine.nix # custom statusline
    ./nixvim/noice.nix # custom CMDLINE
    ./nixvim/nvim-tree.nix # filetree
    ./nixvim/treesitter-context.nix # context line
    ./nixvim/treesitter.nix # syntax highlighting
    ./nixvim/which-key.nix # show keybind hints
    ./nixvim/conform-nvim.nix # formatter
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

    keymaps = [
  {
    # make gf create the file if it doesnt exist
    # cd to the working directory to handle relative file paths
    key = "gf";
    action = ":cd %:p:h<CR>:e <cfile><CR>";
    options = {
      silent = true;
    };
  }
];


    clipboard.providers.wl-copy.enable = true;
  };
}

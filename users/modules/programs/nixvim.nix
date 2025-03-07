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
      shiftwidth = 2;
      number = true;
      relativenumber = true;
      termguicolors = true;
      wrap = false;
    };

    clipboard.providers.wl-copy.enable = true;
  };
}

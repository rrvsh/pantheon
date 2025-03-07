{ inputs, ... }: {
  imports = [ 
    inputs.nixvim.homeManagerModules.nixvim 
    ./nixvim-plugins/nvim-tree.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfigLua = ""; 
    extraPlugins = [];

    opts = {
      shiftwidth = 2;
      number = true;
      relativenumber = true;
    };

    clipboard.providers.wl-copy.enable = true;

    colorschemes = {
      catppuccin.enable = true;
    };
  };
}

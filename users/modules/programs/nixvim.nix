{ inputs, ... }: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    extraConfigLua = "";
    extraPlugins = [];

    opts = {
      shiftwidth = 2;
      number = true;
      relativenumber = true;
    };

    colorschemes = {
      catppuccin.enable = true;
    };

    plugins = {
      lualine.enable = true;
    };
  };
}

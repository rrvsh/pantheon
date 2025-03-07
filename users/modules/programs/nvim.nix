{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      vim.opt.shiftwidth = 2;
      vim.opt.number = true;
      vim.opt.relativenumber = true;
    '';
  };
}

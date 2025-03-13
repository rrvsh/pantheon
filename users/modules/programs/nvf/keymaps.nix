{
  programs.nvf.settings.vim.keymaps = [
    {
      key = "gf";
      mode = "n";
      action = ":cd %:p:h<CR>:e <cfile><CR>";
      silent = true;
    }
  ];
}

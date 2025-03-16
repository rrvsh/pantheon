{
  programs.nvf.settings.vim = {
    lsp = {
      formatOnSave = true;
      lightbulb.enable = true;
      lspkind.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
    };
    binds = {
      cheatsheet.enable = true;
      whichKey.enable = true;
    };
    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
    notes.todo-comments.enable = true;
    telescope.enable = true;
    statusline.lualine.enable = true;
    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
    };
    notify.nvim-notify.enable = true;
    visuals = {
      fidget-nvim.enable = true;
      indent-blankline.enable = true;
      rainbow-delimiters.enable = true;
      nvim-web-devicons.enable = true;
      tiny-devicons-auto-colors.enable = true;
    };
    ui = {
      borders.enable = true;
      breadcrumbs.enable = true;
      breadcrumbs.navbuddy.enable = true;
      colorizer.enable = true;
      noice.enable = true;
      nvim-ufo.enable = true;
    };
    utility = {
      ccc.enable = true;
      images.image-nvim = {
        enable = true;
        setupOpts.backend = "kitty";
      };
      yazi-nvim.enable = true;
      yazi-nvim.setupOpts.open_for_directories = true; # FIXME: does this work with neotree?
    };
  };
}

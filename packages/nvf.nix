{pkgs, ...}: {
  config.vim = {
    # TODO: Install catppuccin
    theme.enable = true;

    options = {
      # Indentation
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      shiftround = true;
      smarttab = true;
      smartindent = true;

      # Visual Settings
      cursorline = true;

      # signcolumn = "no";
    };

    # Built-Ins
    autocomplete.blink-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;
    binds.whichKey.enable = true;
    comments.comment-nvim.enable = true;
    formatter.conform-nvim.enable = true;

    # Filetree
    filetree.nvimTree = {
      enable = true;
      # TODO:
      # - open on right pane instead
      # - keybind to open and close
      # - allow me to move files around with vim bindings
    };

    # Languages
    languages = {
      markdown.enable = true;
    };

    languages.nix = {
      enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      extraDiagnostics.enable = true;
    };

    # Lazy Loaded Plugins
    lazy.plugins = {
      # aerial.nvim = { package = aerial.nvim; after = "print('aerial loaded')"; };
    };
    # Load Plugins after Built-Ins
    extraPlugins = with pkgs.vimPlugins; {
      #harpoon = { package = harpoon; setup = "require('harpoon').setup {}"; };
    };
    # Add directly to init.lua
    # Attribute names denote the section names
    #luaConfigRC = { aquarium = "vim.cmd('colorscheme aquarium')"; };
  };
}

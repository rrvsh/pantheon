_: {
  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

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
    autocomplete.blink-cmp.setupOpts.signature.enabled = true;
    autopairs.nvim-autopairs.enable = true;
    binds.whichKey.enable = true;
    comments.comment-nvim.enable = true;
    formatter.conform-nvim.enable = true;
    dashboard.alpha.enable = true;

    # Filetree
    filetree.nvimTree = {
      enable = true;
      mappings.toggle = "t";
      setupOpts = {
        git = {
          enable = true;
        };
        hijack_cursor = true;
        view.side = "right";
        disable_netrw = true;
        hijack_netrw = true;
      };
      # TODO:
      # - allow me to move files around with vim bindings
    };

    # Fuzzy Finding
    fzf-lua = {
      enable = true;
      profile = "default";
    };
    telescope = {
      enable = true;
    };

    # Git Integration
    git = {
      enable = true;
      git-conflict.enable = true;
      gitsigns.enable = true;
      vim-fugitive.enable = true;
    };

    # Languages
    languages = {
      # Global Defaults
      enableDAP = true;
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      # Specific Languages
      bash.enable = true;
      clang.enable = true;
      csharp.enable = true;
      css.enable = true;
      go.enable = true;
      html.enable = true;
      java.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix.enable = true;
      python.enable = true;
      rust.enable = true;
      ts.enable = true;
      # yaml.enable = true;

      # Markdown
      markdown.extensions.render-markdown-nvim.enable = true;

      # Rust
      rust.crates.enable = true;

      # Typescript
      ts.extensions.ts-error-translator.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lightbulb.enable = true;
      # lspSignature.enable = true;
      lspconfig.enable = true;
      lspkind.enable = true;
      lsplines.enable = true;
      null-ls.enable = true;
      nvim-docs-view.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
    };

    mini = {
      animate.enable = true;
      statusline.enable = true;
      surround.enable = true;
    };
  };
}

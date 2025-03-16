{lib, ...}: {
  programs.nvf.settings.vim = {
    autopairs = {
      nvim-autopairs.enable = true;
    };
    autocomplete = {
      enableSharedCmpSources = true;
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        mappings = {
          # default mappings:
          # - Close [blink.cmp]:<C-e>
          # - Complete [blink.cmp]:<C-Space>
          # - Confirm [blink.cmp]:<CR>
          # - Next item [blink.cmp]:<Tab>
          # - Previous item [blink.cmp]:<S-Tab>
          # - Scroll docs down [blink.cmp]:<C-f>
          # - Scroll docs up [blink.cmp]:<C-d>
        };
        setupOpts = {
          # Disable completion for markdown
          enabled =
            lib.generators.mkLuaInline
            /*
            lua
            */
            ''
              function()
                return not vim.tbl_contains({"markdown"}, vim.bo.filetype)
                  and vim.bo.buftype ~= "prompt"
                  and vim.b.completion ~= false
                end
            '';
          cmdline.sources = null; # use default source list
          sources.providers.cmdline.module = "blink.cmp.sources.cmdline";
          # menu.auto_show = false;
          completion.documentation.auto_show_delay_ms = 0;
          signature.enabled = true;
        };
      };
      nvim-cmp = {};
    };
    # enable code snippets using luasnip
    # loads from vscode by default using friendly-snippets
    snippets.luasnip = {
      enable = true;
      setupOpts = {
        enable_autosnippets = true;
      };
    };
    binds = {
      # cheatsheet.nvim provides cheatsheets with fuzzy finding with <leader>?
      cheatsheet.enable = true;
      # whichkey provides a popup window with hotkeys
      whichKey.enable = true;
    };
  };
}

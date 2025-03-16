{lib, ...}: {
  programs.nvf.settings.vim = {
    autopairs = {
      nvim-autopairs.enable = true;
    };
    autocomplete = {
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
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
          cmdline = {
            enabled = true;
            sources = null;
            completion.menu.auto_show = false;
          };
          # menu.auto_show = false;
          completion.documentation.auto_show_delay_ms = 0;
          signature.enabled = true;
        };
      };
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

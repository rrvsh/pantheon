{lib, ...}: {
  programs.nvf.settings.vim = {
    autopairs.nvim-autopairs.enable = true;
    snippets.luasnip = {
      enable = true;
      setupOpts.enable_autosnippets = true;
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
    utility = {
      motion = {
        hop.enable = true; # <leader>h
        precognition.enable = false;
      };
      yanky-nvim.enable = true;
    };
  };
}

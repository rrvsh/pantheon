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
          enabled =
            lib.generators.mkLuaInline
            /*
            lua
            */
            ''
              --- Disable completion for markdown
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
          completion.menu.auto_show =
            lib.generators.mkLuaInline
            /*
            lua
            */
            ''
              function(ctx)
                --- Get the cursor position from the current window
                local row, column = unpack(vim.api.nvim_win_get_cursor(0))
                --- Get the current row (1 is Neovim API giving us 1-based indexing)
                --- Get the current column but don't return negative numbers
                --- ignore_injections are to ignore embedded code
                --- success is the result, node is the syntax node object
                local success, node = pcall(vim.treesitter.get_node, {
                  pos = {row - 1, math.max(0, column - 1)},
                  ignore_injections = false
                })
                --- Types of nodes to ignore
                local reject = {"comment", "line_comment", "block_comment", "string_start", "string_content", "string_end" }
                --- If the node type is in the reject table, don't show the completion
                if success and node and vim.tbl_contains(reject, node:type()) then
                  return false;
                end
                -- whatever other logic you want beyond this
                return true
              end
            '';
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

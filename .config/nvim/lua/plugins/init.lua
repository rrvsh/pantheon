return { -- Lua table
  -- nvim.tree.lua
  "nvim-tree/nvim-tree.lua", -- github repo
  version = "*", -- latest version
  lazy = false, -- dont use lazy loading
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    hijack_cursor = true, -- makes cursor stick to first char
    view = {
      side = "right",
    }, 
  },

  -- catppuccin
  { 
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    version = "*",
    lazy = false,
    config = function()
      vim.cmd.colorscheme = "catppuccin"
    end,
  },
}

return { -- Lua table
  -- catppuccin
  { 
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    version = "*",
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
      vim.cmd.colorscheme = "catppuccin"
    end,
  },

  -- nvim.tree.lua
  {
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
  },
}

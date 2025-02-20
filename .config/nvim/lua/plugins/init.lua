return { -- Lua table
  "nvim-tree/nvim-tree.lua", -- github repo
  version = "*", -- latest version
  lazy = false, -- dont use lazy loading
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      hijack_cursor = true, -- makes cursor stick to first char
      view = {
        side = "right",
      },
    }
  end,
}

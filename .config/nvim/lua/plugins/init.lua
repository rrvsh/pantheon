return { -- Lua table
  "nvim-tree/nvim-tree.lua", -- github repo
  version = "*", -- latest version
  lazy = false, -- dont use lazy loading
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}

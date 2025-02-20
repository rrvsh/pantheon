-- Plugins
require("config.lazy")
vim.g.loaded_netrw = 1        -- Disables netrw
vim.g.loaded_netrwPlugin = 1  -- for nvim-tree

-- Visual
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.cursorline = true -- Highlight current line

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false

-- Visual tweaks
vim.opt.termguicolors = true -- Enable true color support in the terminal
vim.opt.background = "dark" -- Or "light" depending on your preference
vim.opt.signcolumn = "yes" -- Always show sign column (for diagnostics, etc.)
vim.opt.guifont = "Terminess Mono Nerd Font:h12"

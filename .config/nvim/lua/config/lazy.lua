-- Bootstrap lazy.nvim --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Get the path for the vim install and append /lazy/lazy.nvim to it

if not (vim.uv or vim.loop).fs_stat(lazypath) then -- Check if the directory does not exist
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  -- vim.fn.system calls a shell command
  -- git clone --filter=blob:none only downloads the metadata
  -- vim.v.shell_error checks exit code of shell command from last vim.fn.system
  -- ~= is !=
  if vim.v.shell_error ~= 0 then -- check if clone successful
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, 
    true, -- true here displays it as an echo message, overwriting prev msgs
    {})   -- empty list of options 
    vim.fn.getchar() -- wait for user input
    os.exit(1)
  end
end

-- vim.opt.rtp is the runtime path (plugins, syntax files, etc)
-- prepend adds lazypath to the start of the runtime path
vim.opt.rtp:prepend(lazypath)

-- Set Neovim settings here --

-- vim.g is global scope of nvim vars
vim.g.mapleader = " "       -- prefix for user defined commands
vim.g.maplocalleader = "\\" -- prefix for buffer local mappings (one backslash only)

-- Setup lazy.nvim --

require("lazy").setup({ -- loads the lazy module
  spec = {
    -- Import plugins here
    { import = "plugins" },
  },
  -- Configure other settings here.
  rocks = {
    hererocks = true,
  },
  install = {
    colorscheme = { "habamax" }
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

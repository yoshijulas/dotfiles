-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable Neovim 0.11+ built-in dir.lua directory plugin
vim.g.loaded_nvim_dir_plugin = 0

-- Disable format on save
-- Undo LazyVim default: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua#L6
vim.g.autoformat = false

-- Set a fixed column guide at 80 or 100 characters
vim.opt.colorcolumn = "100"

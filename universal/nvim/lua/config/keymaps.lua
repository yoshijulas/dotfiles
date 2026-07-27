-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- paste over selection without loosing yanked
map("x", "p", [["_dP]])

local clip = require("util.clipboard")
-- normal mode: copy just the file path
vim.keymap.set("n", "<leader>cp", function()
  clip.copy_ref({})
end, { desc = "Copy file path" })
-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>cp", function()
  clip.copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })

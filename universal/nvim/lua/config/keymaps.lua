-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- paste over selection without loosing yanked
map("x", "p", [["_dP]])

-- Native multicursor clear: LazyVim maps <C-l> to window-right, which shadows
-- the builtin CTRL-L clear (and on this nightly the default handler doesn't
-- fire anyway). Bind <C-l> explicitly to the documented namespace clear.
-- Revert: delete the block below to restore LazyVim's window-right.
map("n", "<C-l>", function()
  local ns = vim.api.nvim_create_namespace("nvim.multicursor")
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end, { desc = "Clear multicursors" })

local clip = require("util.clipboard")
-- normal mode: copy just the file path
vim.keymap.set("n", "<leader>cp", function()
  clip.copy_ref({})
end, { desc = "Copy file path" })
-- visual mode: copy the file path plus the selected line range
vim.keymap.set("v", "<leader>cp", function()
  clip.copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })

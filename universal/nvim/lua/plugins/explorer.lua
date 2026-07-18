-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  {
    "FylerOrg/fyler.nvim",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    opts = {
      integrations = {
        -- Use mini.icons as the icon provider
        icon = "mini_icons",
      },
    },
    keys = {
      {
        "<leader>-",
        mode = "n",
        "<cmd>Fyler<cr>",
        desc = "Open Fyler explorer",
      },
    },
    -- }, keys = {("n", "<leader>e", fyler.open, { desc = "fyler.nvim - open" })}
  },
  -- {
  --   "stevearc/oil.nvim",
  --   dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  --   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  --   lazy = false,
  --   opts = {
  --     columns = {
  --       "icon",
  --       -- "permissions",
  --       "size",
  --       -- "mtime",
  --     },
  --     -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  --     delete_to_trash = true,
  --     view_options = {
  --       show_hidden = true,
  --     },
  --     win_options = {
  --       winbar = "%!v:lua.get_oil_winbar()",
  --     },
  --   },
  --
  --   keys = {
  --     { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  --     {
  --       "<leader>-",
  --       function()
  --         require("oil").toggle_float()
  --       end,
  --       desc = "Oil float",
  --     },
  --   },
  --
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = "oil",
  --       callback = function()
  --         vim.opt_local.cursorline = true
  --       end,
  --     })
  --   end,
  -- },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>=",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
    },
  },
}

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
      extensions = {
        git = { enabled = true },
        trash = { enabled = true },
      },
      ui = {
        indent_guides = true,
      },
      follow_current_file = true,
    },

    keys = {
      {
        "<leader>-",
        mode = "n",
        -- "<cmd>Fyler<cr>",
        function()
          require("fyler").open()
        end,
        desc = "Open Fyler explorer",
      },
    },
    -- }, keys = {("n", "<leader>e", fyler.open, { desc = "fyler.nvim - open" })}
  },
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
    opts = {
      -- open Yazi automatically when starting Neovim on a directory (e.g. nvim .)
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    init = function()
      -- mark netrw as loaded so it's not loaded at all.
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
}

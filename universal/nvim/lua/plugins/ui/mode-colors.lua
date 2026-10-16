return {
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
    opts = {
      -- moods colors
      colors = {
        normal = "#00BFFF",
        insert = "#70CF67",
        visual = "#AD6FF7",
      },
      blends = 0.1,
      disabled = {
        filetypes = { "TelescopePrompt" },
      },
      extend = {
        line_number = true, -- colour the line-number column too
      },
      recording = { enabled = true },
    },
  },
  -- {
  --   "mvllow/modes.nvim",
  --   config = function()
  --     require("modes").setup({
  --       colors = {
  --         bg = "", -- Optional bg param, defaults to Normal hl group
  --         copy = "#f5c359",
  --         delete = "#c75c6a",
  --         change = "#c75c6a", -- Optional param, defaults to delete
  --         format = "#c79585",
  --         insert = "#78ccc5",
  --         replace = "#245361",
  --         select = "#9745be", -- Optional param, defaults to visual
  --         visual = "#9745be",
  --       },

  --       colors = {
  --         copy = "#00BFFF", -- normal
  --         delete = "#EB788B", -- command
  --         change = "#FF8F40", -- operator
  --         format = "#C79585",
  --         insert = "#70CF67",
  --         replace = "#E66767",
  --         select = "#AD6FF7", -- visual
  --         visual = "#AD6FF7",
  --       },
  --
  --       -- Set opacity for cursorline and number background
  --       line_opacity = 0.2,
  --
  --       -- Enable cursor highlights
  --       set_cursor = true,
  --
  --       -- Enable cursorline initially, and disable cursorline for inactive windows
  --       -- or ignored filetypes
  --       set_cursorline = true,
  --
  --       -- Enable line number highlights to match cursorline
  --       set_number = true,
  --
  --       -- Enable sign column highlights to match cursorline
  --       set_signcolumn = true,
  --
  --       -- Disable modes highlights for specified filetypes
  --       -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
  --       -- Can also be a function fun():boolean that disables modes highlights when true
  --       ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
  --     })
  --   end,
  -- },
}

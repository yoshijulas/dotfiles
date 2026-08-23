  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "100",
      disabled_filetypes = {
        "alpha",
        "checkhealth",
        "help",
        "lazy",
        "markdown",
        "mason",
        "ministarter",
        "neo-tree",
        "octo",
        "oil",
        "snacks_dashboard",
        "text",
      },
    },
  },
  {
    "celeste3z/celeste_comment.nvim",
    lazy = false,
    opts = {},
  },
  {
    "svampkorg/moody.nvim",
    event = { "ModeChanged", "BufWinEnter", "WinEnter" },
    opts = {
      -- one blend for every mode, or a per-mode table (see Configuration)
      blends = 0.1,
      colors = {
        normal = "#00BFFF",
        insert = "#70CF67",
        visual = "#AD6FF7",
      },
      disabled = {
        filetypes = { "TelescopePrompt" },
      },
      extend = {
        line_number = true, -- colour the line-number column too
      },
      recording = { enabled = true },
      column = {
        enabled = false, -- replace 'statuscolumn' with moody's
        numbers = true, -- show line numbers
        signs = true, -- show the sign column
        folds = {
          enabled = true,
          start_color = "#C1C1C1", -- gradient start across fold levels
          end_color = "#2F2F2F", -- gradient end
        },
        marks = {
          enabled = true,
          alphabetic = true, -- a-z / A-Z marks
          other = false, -- non-alphabetic marks
        },
        highlight = {}, -- base highlight for the column, e.g. { bg = "#101010" }
        separator = {
          char = "", -- drawn between the column and the code
          highlight = {}, -- e.g. { fg = "#333333" }; defaults to CursorLine bg
        },
      },
    },
  },

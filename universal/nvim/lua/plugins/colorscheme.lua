return {
  {
    "sainnhe/everforest",
    lazy = true,
    name = "everforest",
    priority = 1000,
    init = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_ui_contrast = "high"
      vim.g.everforest_enable_italic = 1
      -- vim.g.everforest_diagnostic_text_highlight = "1"
      -- vim.g.everforest_diagnostic_line_highlight = "1"
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    priority = 1000,
    init = function()
      -- vim.g.sonokai_style = "maia" -- Green
      -- vim.g.sonokai_style = "shusia" -- Brown
      vim.g.sonokai_style = "espresso" -- More brown
      vim.g.sonokai_enable_italic = 1
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
      -- colorscheme = "catppuccin-macchiato",
      -- colorscheme = "sonokai",
    },
  },
}

return {
  {
    "https://github.com/sainnhe/everforest",
    name = "everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_ui_contrast = "low"
      -- vim.g.everforest_diagnostic_text_highlight = "1"
      -- vim.g.everforest_diagnostic_line_highlight = "1"
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-macchiato",
      colorscheme = "everforest",
    },
  },
}

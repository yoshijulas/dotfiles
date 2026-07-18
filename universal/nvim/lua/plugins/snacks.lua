return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      size = 8 * 1024 * 1024,
      --   enabled = false,
    },
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 32,
            },
          },
        },
      },
    },
  },
}

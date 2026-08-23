return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      size = 8 * 1024 * 1024,
      --   enabled = false,
    },
    explorer = {
      enabled = true,
      replace_netrw = false, -- Replace netrw with the snacks explorer
      trash = true, -- Use the system trash when deleting files
    },
    picker = {
      layout = {
        -- Change later to default if feels weird
        preset = "ivy_split",
      },
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

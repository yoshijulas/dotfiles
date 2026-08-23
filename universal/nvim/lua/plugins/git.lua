return {
  -- Keep Testing
  -- {
  --   "emrearmagan/atlas.nvim",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons", -- optional but recommended
  --     "MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
  --     "esmuellert/codediff.nvim", -- optional (PullRequest diff)
  --     "sindrets/diffview.nvim", -- optional; or "dlyongemallo/diffview-plus.nvim"
  --   },
  --   -- See Configuration below
  --   opts = {},
  -- },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {},
  },
  {
    "neogitorg/neogit",
    cmd = "Neogit",
    dependencies = {
      "esmuellert/codediff.nvim",
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    },
    opts = {
      diff_viewer = "codediff",
      integrations = {
        codediff = true,
        snacks = true,
      },
    },
  },
}

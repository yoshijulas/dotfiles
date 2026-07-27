return {
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

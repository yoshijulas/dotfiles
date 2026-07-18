return {
  -- {
  --   "nvim-mini/mini.splitjoin",
  --   opts = { {
  --     mappings = {
  --       toggle = "gS",
  --     },
  --   } },
  -- },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>m",
        function()
          require("treesj").toggle()
        end,
        mode = { "n", "x" },
        desc = "Treesj - Toggle",
      },
      {
        "<leader>M",
        function()
          require("treesj").toggle({ split = { recursive = true } })
        end,
        mode = { "n", "x" },
        desc = "Treesj - Toggle Recursive",
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}

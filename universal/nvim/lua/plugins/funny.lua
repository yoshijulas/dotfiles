return {
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      {
        "<leader>fml",
        mode = "n",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Cellular Automaton make_it_rain",
      },
    },
  },
  {
    -- :WrappedNvim
    "aikhe/wrapped.nvim",
    cmd = { "WrappedNvim" },
    dependencies = { "nvzone/volt" },
    opts = {},
  },
}

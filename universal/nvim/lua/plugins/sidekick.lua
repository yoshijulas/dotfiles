return {
  "folke/sidekick.nvim",
  opts = {
    -- next-edit-suggestions need a Copilot sub; completion is handled by minuet
    nes = { enabled = false },
    cli = {
      tools = {
        agy = {
          cmd = { "agy" },
        },
      },
    },
  },
}

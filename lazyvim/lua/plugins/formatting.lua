return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- 1. Force JavaScript files to use biome-check instead of Prettier
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.javascript = { "biome-check" }

    -- 2. Bump the timeout to 5 seconds so massive files don't instantly fail
    opts.timeout_ms = 5000

    -- 3. Strip away the project root directory requirement for Biome
    opts.formatters = opts.formatters or {}
    opts.formatters["biome-check"] = {
      condition = function(self, ctx)
        return true
      end,
    }

    return opts
  end,
}

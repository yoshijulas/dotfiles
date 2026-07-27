return {
  "stevearc/conform.nvim",
  optional = true,
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.toml = opts.formatters_by_ft.toml or {}
    table.insert(opts.formatters_by_ft.toml, "taplo")

    opts.formatters = opts.formatters or {}
    opts.formatters.taplo = {
      args = {
        "fmt",
        "-o",
        "compact_entries=false",
        "-o",
        "align_entries=true",
        "-",
      },
    }
  end,
}

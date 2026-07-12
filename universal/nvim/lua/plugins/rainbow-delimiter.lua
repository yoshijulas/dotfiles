local enabled = true

return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    -- Load on standard file read events (replaces AstroFile)
    event = { "BufReadPost", "BufNewFile" },
    main = "rainbow-delimiters.setup",

    -- Keys mapped standard lazy.nvim style (replaces astrocore mappings)
    keys = {
      {
        "<leader>u(",
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          require("rainbow-delimiters").toggle(bufnr)
          vim.notify(
            string.format(
              "Buffer rainbow delimiters %s",
              require("rainbow-delimiters").is_enabled(bufnr) and "on" or "off"
            )
          )
        end,
        desc = "Toggle rainbow delimiters (buffer)",
      },
      {
        "<leader>u)",
        function()
          local rainbow_delimiters = require("rainbow-delimiters")
          enabled = not enabled
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if enabled then
              rainbow_delimiters.enable(bufnr)
            else
              rainbow_delimiters.disable(bufnr)
            end
          end
          vim.notify(string.format("Global rainbow delimiters %s", enabled and "on" or "off"))
        end,
        desc = "Toggle rainbow delimiters (global)",
      },
    },
    opts = {
      condition = function(bufnr)
        if not enabled then
          return false
        end
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return false
        end

        -- Skip large files (e.g. > 100 KB) to prevent editor lag
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > 100 * 1024 then
          return false
        end

        return true
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    optional = true,
    opts = { integrations = { rainbow_delimiters = true } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    opts = function(_, opts)
      if not opts.scope then
        opts.scope = {}
      end
      opts.scope.highlight = vim.tbl_get(vim.g, "rainbow_delimiters", "highlight")
        or {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        }
    end,

    config = function(plugin, opts)
      require(plugin.main).setup(opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}

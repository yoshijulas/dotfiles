return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- 1. Clear Tab so it doesn't accept AI suggestions
      opts.keymap["<Tab>"] = { "snippet_forward", "fallback" }

      -- 2. Manually call the LazyVim action via a function
      opts.keymap["<M-f>"] = {
        function(cmp)
          if LazyVim.cmp.actions.ai_accept() then
            return true -- tells blink we handled the keypress
          end
        end,
        "fallback",
      }

      return opts
    end,
  },
}

-- return {
--   "monkoose/neocodeium",
--   event = "VeryLazy",
--   config = function()
--     local neocodeium = require("neocodeium")
--     neocodeium.setup()
--     vim.keymap.set("i", "<A-f>", neocodeium.accept)
--   end,
-- }

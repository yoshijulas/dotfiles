return {
  {
    "nvim-mini/mini.statuscolumn",
    version = false,
    -- event = 'BufReadPre',
    opts = function()
      return {
        content = require("mini.statuscolumn").gen_content.main({
          -- Put the sign to the left of the line number with some alignment so it's not too compact
          { format = "s=l=f", sep = " " },
          -- Use custom symbol for virtual lines
          { ltype = "virt", lnum = "•" },
          -- Use custom symbol for wrapped lines
          { ltype = "wrap", lnum = "↳" },
          -- Hide separator to better indicate inactive windows
          { win = "inactive", sep = " " },
        }),
        dim_inactive = false,
      }
    end,
  },
}

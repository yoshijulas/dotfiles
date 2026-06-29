return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    ignore = function(buf)
      local bufname = vim.api.nvim_buf_get_name(buf)
      local vault_path = vim.fn.expand("~/vaults/")
      -- Check if the file is inside the ~/vaults/ directory
      if bufname:sub(1, #vault_path) == vault_path then
        return true
      end
      return false
    end,
  },
}

return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    -- Include the default AstroNvim configuration for luasnip
    require("astronvim.plugins.configs.luasnip")(plugin, opts)

    -- Load custom vscode snippets from the "snippets" directory
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })
  end,
}

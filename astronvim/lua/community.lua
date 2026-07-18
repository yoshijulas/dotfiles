-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Themes
  { import = "astrocommunity.colorscheme.everforest" },

  -- Packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.rainbow-delimiter-indent-blankline" },

  -- Utilities
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.editing-support.mini-ai" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.file-explorer.oil-nvim" },
}

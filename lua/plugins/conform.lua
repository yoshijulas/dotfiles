-- uncomment so i can be dynamic set if use biome or prettier/d, right now is using biome only
--
-- local formatters = { "biome", "prettierd", "prettier" }
--
-- local function find_config(bufnr, config_files)
--   return vim.fs.find(config_files, {
--     upward = true,
--     stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
--     path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
--   })[1]
-- end
--
-- local function biome_or_prettier(bufnr)
--   local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })
--   if has_biome_config then
--     return { "biome", stop_after_first = true }
--   end
--
--   local has_prettier_config = find_config(bufnr, {
--     ".prettierrc",
--     ".prettierrc.json",
--     ".prettierrc.yml",
--     ".prettierrc.yaml",
--     ".prettierrc.json5",
--     ".prettierrc.js",
--     ".prettierrc.cjs",
--     ".prettierrc.toml",
--     "prettier.config.js",
--     "prettier.config.cjs",
--   })
--   if has_prettier_config then
--     return { "prettier", stop_after_first = true }
--   end
--
--   -- Default to Prettier if no config is found
--   return { "prettier", stop_after_first = true }
-- end
--
local filetypes_with_dynamic_formatter = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

local formatters_by_ft = {}
for _, ft in ipairs(filetypes_with_dynamic_formatter) do
  formatters_by_ft[ft] = { "biome" }
end

-- return {
--   {
--     "stevearc/conform.nvim",
--     opts = function(_, opts)
--       opts.formatters = opts.formatters or {}
--       opts.formatters.biome = {
--         single_file_support = true,
--       }
--
--       opts.formatters_by_ft = {}
--       for _, ft in ipairs(filetypes_with_dynamic_formatter) do
--         opts.formatters_by_ft[ft] = { "biome" }
--       end
--
--       return opts
--     end,
--   },
-- }

return {}
--
-- return {
--   {
--     "stevearc/conform.nvim",
--     opts = {
--       formatters_by_ft = formatters_by_ft,
--
--       formatter = {
--         biome = {
--           single_file_support = true,
--         },
--       },
--     },
--   },
-- }

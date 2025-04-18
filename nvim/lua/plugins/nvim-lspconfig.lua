return {
  "neovim/nvim-lspconfig",
  config = {
    servers = {
      biome = {
        filetypes = {
          "astro",
          "css",
          "graphql",
          "javascript",
          "javascriptreact",
          "json",
          "jsonc",
          "svelte",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "vue",
        },
        single_file_support = true,
      },
    },
  },
}

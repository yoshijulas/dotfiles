return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = {
              "--",
              "-Wclippy::pedantic",
              "-Wclippy::nursery",
              "-Aclippy::cast_sign_loss",
              "-Aclippy::cast_possible_wrap",
            },
          },
        },
      },
    },
  },
}

--
-- return {
--   -- 1. Configure bacon-ls with your custom Clippy rules
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         bacon_ls = {
--           settings = {
--             bacon_ls = {
--               backend = "cargo",
--               cargo = {
--                 command = "clippy",
--                 extraArgs = {
--                   "--",
--                   "-Wclippy::dbg_macro",
--                   "-Wclippy::todo",
--                   "-Wclippy::disallowed_macros",
--                   "-Wclippy::pedantic",
--                   "-Wclippy::nursery",
--                   "-Aclippy::cast_sign_loss",
--                   "-Aclippy::cast_possible_wrap",
--                   "-Aclippy::cast_possible_truncation",
--                   "-Aclippy::cast_precision_loss",
--                 },
--               },
--             },
--           },
--         },
--       },
--     },
--   },
--   -- 2. Keep rustfmt in rust-analyzer, but disable rust-analyzer's internal diagnostics
--   {
--     "mrcjkb/rustaceanvim",
--     opts = {
--       server = {
--         default_settings = {
--           ["rust-analyzer"] = {
--             rustfmt = {
--               extraArgs = { "+nightly" },
--             },
--           },
--         },
--       },
--     },
--   },
-- }

return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          rustfmt = {
            extraArgs = { "+nightly" },
          },
          check = {
            command = "clippy",
            extraArgs = {
              "--",
              "-Wclippy::dbg_macro",
              "-Wclippy::todo",
              "-Wclippy::disallowed_macros",
              "-Wclippy::pedantic", -- Enable extra-strict lints for idiomatic/clean code
              "-Wclippy::nursery", -- Enable experimental/in-development Clippy lints
              "-Aclippy::cast_sign_loss", -- Allow signed to unsigned casts (e.g., i32 -> u32, isize -> usize)
              "-Aclippy::cast_possible_wrap", -- Allow casts that might wrap signs (e.g., u32 -> i32)
              "-Aclippy::cast_possible_truncation", -- Allow larger to smaller int casts (e.g., u32 -> u8, usize -> u32)
              "-Aclippy::cast_precision_loss", -- Allow int to float casts that may lose bits (e.g., usize -> f32)
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

return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
            extraArgs = { "--", "-Wclippy::pedantic", "-Wclippy::nursery" },
          },
        },
      },
    },
  },
}

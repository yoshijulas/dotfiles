return {
  -- Treesitter grammar (carried over from the lazyvim lang.nix extra)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "nix") then
        table.insert(opts.ensure_installed, "nix")
      end
    end,
  },
  -- nixd comes from nixpkgs on NixOS, pacman/nix on CachyOS (no mason package exists).
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {},
      },
    },
  },
  -- statix/nixfmt install via mason on non-NixOS; on NixOS the mason plugin
  -- is disabled (see plugins/mason-nixos.lua) so this block is inert there.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      for _, tool in ipairs({ "statix", "nixfmt" }) do
        if not vim.tbl_contains(opts.ensure_installed, tool) then
          table.insert(opts.ensure_installed, tool)
        end
      end
    end,
  },
  -- formatting + linting (carried over from the extra)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = { "statix" },
      },
    },
  },
}

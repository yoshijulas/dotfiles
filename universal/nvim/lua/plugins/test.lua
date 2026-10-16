return {
  {
    "mihovilrak/scroll.nvim",
    opts = {
      visibility = "always",
    },
  },
  {
    "wellatleastitried/bitwise-visualizer.nvim",
    main = "bitwise-visualizer",
    event = "VeryLazy",
    opts = {
      -- everything is optional; see the configuration reference
      width = "auto",
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    opts = {
      calm_down = true,
    },
    config = function(_, opts)
      require("hlslens").setup(opts)

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
  {
    "abecodes/tabout.nvim",
    event = "InsertCharPre",
    opts = {},
  },
  -- {
  --   "leolaurindo/tunnelvision.nvim",
  --   opts = {},
  -- },
  -- {
  --   "tadaa/vimade",
  --   opts = {
  --     recipe = { "default", { animate = true } },
  --     fadelevel = 0.4,
  --   },
  -- },
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
  },
  {
    "CoreyKaylor/diffbandit.nvim",
    opts = {
      diff = {
        ignore_whitespace = false,
      },
      navigation = {
        initial_focus = "right",
        align_on_jump = true,
        align_strategy = "change_top",
        document_keys = {
          top = "[d",
          bottom = "]d",
        },
        snap_key = "]s",
      },
      git = {
        default_mode = "all",
        include_untracked = true,
        find_renames = true,
        file_keys = {
          next = "]f",
          prev = "[f",
        },
        panel = {
          width = 42,
          commit_height = 10,
          preview_on_cursor = true,
          keys = {
            toggle_stage = "<Space>",
            focus_diff = "<CR>",
            focus_panel = "C",
            focus_commit = "cc",
            file_actions = "a",
            toggle_amend = "<Space>",
            refresh = "R",
            close = "q",
          },
        },
      },
      merge = {
        result_initial_content = "base",
        auto_apply_non_conflicting = false,
        resolve_on_write = true,
        line_endings = {
          warn = true,
        },
        keys = {
          next_conflict = "]c",
          prev_conflict = "[c",
          accept_local = ">>",
          accept_remote = "<<",
          accept_both = "gb",
          apply_non_conflicting = "gA",
          focus_panel = "C",
          snap = "]s",
          toggle_panel = "gzp",
          toggle_local = "gzh",
          toggle_remote = "gzl",
          show_all = "gza",
          close = "q",
        },
      },
      folder = {
        gutter_width = 7,
        columns = {
          size = true,
          modified = true,
        },
        compare = {
          mode = "digest",
          backend = "auto",
          batch_size = 64,
          max_concurrency = 2,
          debounce_ms = 50,
        },
        filters = {
          include = {},
          exclude = {},
        },
        keys = {
          open = "<CR>",
          alternate_open = "o",
          toggle_expand = "<Space>",
          alternate_toggle_expand = "za",
          expand_all = "zR",
          collapse_all = "zM",
          next_diff = "]c",
          prev_diff = "[c",
          refresh = "R",
          filter = "s",
          close = "q",
        },
      },
      ui = {
        -- Connector core width. Defaults fix the gutter at 9 columns
        -- (min == max). Raise connector_max_width to allow once-per-document
        -- pressure expansion; set both equal for a different fixed width.
        connector_width = 9,
        connector_max_width = 9,
        scroll_debounce_ms = 16,
        split_blend = 0.3,
        overview = {
          enabled = true,
          width = 1,
          cursor = true,
        },
        status = {
          enabled = true,
          icons = "auto",
        },
        theme = {
          auto_refresh = true,
          semantic_blend = 0.3,
          change_emphasis_strength = 0.16,
          min_background_delta = 0.08,
          colors = {
            add = nil,
            delete = nil,
            change = nil,
            change_emphasis = nil,
          },
          highlights = {},
        },
      },
      actions = {
        staged_indicator = {
          unstaged = "□",
          staged = "▣",
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      { "mikavilpas/blink-ripgrep.nvim", version = "*" },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
      if not vim.tbl_contains(opts.sources.default, "ripgrep") then
        table.insert(opts.sources.default, "ripgrep")
      end
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {},
      }
    end,
  },
}

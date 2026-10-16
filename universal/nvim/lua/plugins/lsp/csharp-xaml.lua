return {
  -- Treesitter for C# + XAML (as XML)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      for _, lang in ipairs({ "c_sharp", "xml" }) do
        if not vim.tbl_contains(opts.ensure_installed, lang) then
          table.insert(opts.ensure_installed, lang)
        end
      end
    end,
  },
  -- XAML files get XML syntax/highlighting; keeps .cs XAML code-behind on csharp LS
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- XML language server gives tag completion/hover in *.xaml
        lemminx = {},
      },
    },
    init = function()
      -- *.xaml is XML UI markup; *.cs is C# code (LazyExtra owns that half).
      vim.filetype.add({ extension = { xaml = "xml" } })
      -- OmniSharp's InlayHintService crashes on stale doc versions (-32603).
      -- Stop asking it; lemminx/other servers unaffected.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "omnisharp" then
            vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
          end
        end,
      })
      -- .editorconfig severity is ignored by this OmniSharp build; drop the
      -- style-only codes client-side so they stop spamming the picker.
      local orig_diag = vim.lsp.handlers["textDocument/publishDiagnostics"]
      vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if result and result.diagnostics then
          result.diagnostics = vim.tbl_filter(function(d)
            local code = tostring(d.code or "")
            return code ~= "IDE0008" and code ~= "IDE0002" and code ~= "IDE0032"
          end, result.diagnostics)
        end
        return orig_diag(err, result, ctx, config)
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "lemminx") then
        table.insert(opts.ensure_installed, "lemminx")
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        xml = { "xmllint" },
      },
    },
  },
}

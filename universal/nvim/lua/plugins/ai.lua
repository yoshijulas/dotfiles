return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "VeryLazy",
    config = function()
      require("minuet").setup({
        -- codestral: FIM model, best quality/speed for single-line completions;
        -- switch with :Minuet change_preset groq|gemini|codestral
        provider = "codestral",
        request_timeout = 2.5,
        -- bouncer sized for codestral (cheap FIM requests): snappy but polite
        throttle = 1000,
        debounce = 350,
        context_window = 3000,
        n_completions = 1,
        virtualtext = {
          auto_trigger_ft = { "*" },
          auto_trigger_ignore_ft = {
            "markdown",
            "text",
            "help",
            "gitcommit",
            "gitrebase",
            "codecompanion",
            "snacks_dashboard",
            "oil",
          },
          keymap = {
            -- accept whole suggestion
            accept = "<A-A>",
            -- accept only the current line
            accept_line = "<A-a>",
            accept_n_lines = "<A-z>",
            prev = "<A-[>",
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
        provider_options = {
          openai_compatible = {
            name = "Groq",
            api_key = "GROQ_API_KEY",
            end_point = "https://api.groq.com/openai/v1/chat/completions",
            model = "openai/gpt-oss-20b",
            stream = true,
            optional = {
              max_tokens = 100,
              temperature = 0.2,
              top_p = 0.9,
              -- gpt-oss thinks by default; "none" is rejected by Groq,
              -- "low" keeps latency ~300ms
              reasoning_effort = "low",
            },
          },
          gemini = {
            -- flash-lite variants have the highest free RPD (500/day, 15 RPM);
            -- regular Flash is capped at ~20-23 requests/day
            model = "gemini-flash-lite-latest",
            stream = true,
            api_key = "GEMINI_API_KEY",
            optional = {
              generationConfig = {
                maxOutputTokens = 128,
              },
              safetySettings = {
                { category = "HARM_CATEGORY_DANGEROUS_CONTENT", threshold = "BLOCK_ONLY_HIGH" },
              },
            },
          },
          codestral = {
            model = "codestral-latest",
            end_point = "https://codestral.mistral.ai/v1/fim/completions",
            api_key = "CODESTRAL_API_KEY",
            stream = true,
            optional = {
              max_tokens = 64,
              -- stop at end of line -> strictly single-line suggestions
              stop = { "\n" },
            },
          },
        },
        presets = {
          codestral = { provider = "codestral" },
          groq = { provider = "openai_compatible" },
          gemini = { provider = "gemini" },
        },
      })
      vim.keymap.set("n", "<leader>ac", "<cmd>Minuet virtualtext toggle<cr>", { desc = "AI Completion (Toggle)" })
    end,
  },
  {
    "folke/sidekick.nvim",
    opts = {
      -- next-edit-suggestions need a Copilot sub; completion is handled by minuet
      nes = { enabled = false },
      cli = {
        tools = {
          agy = {
            cmd = { "agy" },
          },
        },
      },
    },
  },
}

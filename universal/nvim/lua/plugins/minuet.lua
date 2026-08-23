return {
  "milanglacier/minuet-ai.nvim",
  keys = {
    { "<leader>at", "<cmd>Minuet virtualtext toggle<cr>", desc = "AI Completion (Toggle)" },
  },
  opts = {
    provider = "openai_compatible",
    request_timeout = 2.5,
    throttle = 1000,
    debounce = 400,
    context_window = 8000,
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
    },
  },
}

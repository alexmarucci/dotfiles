local present, avante = pcall(require, 'avante')
if not present then
  return
end

avante.setup({
  vendors = {
    mistral = {
      endpoint = "https://localhost:8080/v1/chat/completions",
      model = "codestral-22b-v0.1",
      api_key_name = "CODESTRAL_API_KEY",
      parse_curl_args = function(opts, code_opts)
        local api_key = os.getenv(opts.api_key_name)
        local Llm = require("avante.providers")

        return {
          url = opts.endpoint,
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. api_key,
          },
          body = {
            model = opts.model,
            messages = Llm.openai.parse_message(code_opts),
            temperature = 0.7,
            max_tokens = 8192,
            stream = true,
            safe_prompt = false,
          },
        }
      end,
      parse_response_data = function(data_stream, event_state, opts)
        local Llm = require("avante.providers")
        Llm.openai.parse_response(data_stream, event_state, opts)
      end,
    },
  },
  provider = "mistral",                 -- "claude" or "openai" or "azure"

  auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  openai = {
    endpoint = "https://localhost:8080/v1/completions",
    -- model = "claude-3-5-sonnet-20240620",
    model = "codestral-22b-v0.1",
    temperature = 0,
    max_tokens = 4096,
  },
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  mappings = {
    --- @class AvanteConflictMappings
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<C-l>",
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    sidebar = {
      apply_all = "A",
      apply_cursor = "a",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
  },
  hints = { enabled = false },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right", -- the position of the sidebar
    wrap = true,        -- similar to vim.o.wrap
    width = 30,         -- default % based on available width
    sidebar_header = {
      align = "center", -- left, center, right for title
      rounded = true,
    },
    input = {
      prefix = "> ",
    },
    edit = {
      border = "rounded",
      start_insert = true, -- Start insert mode when opening the edit window
    },
    ask = {
      floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
      start_insert = true, -- Start insert mode when opening the ask window, only effective if floating = true.
      border = "rounded",
    },
  },
  highlights = {
    ---@type AvanteConflictHighlights
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },
  --- @class AvanteConflictUserConfig
  diff = {
    autojump = true,
    ---@type string | fun(): any
    list_opener = "copen",
  },
})

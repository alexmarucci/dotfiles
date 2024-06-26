local present, noice = pcall(require, 'noice')
if not present then
  return
end

require("noice").setup({
  lsp = {
    progress = {
      enabled = false,
    },
    message = {
      -- Messages shown by lsp servers
      enabled = false,
    },
    signature = {
      enabled = false,
    },
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  messages = {
    -- NOTE: If you enable messages, then the cmdline is enabled automatically.
    -- This is a current Neovim limitation.
    enabled = false,             -- enables the Noice messages UI
    view = "notify",             -- default view for messages
    view_error = "notify",       -- view for errors
    view_warn = "notify",        -- view for warnings
    view_history = "messages",   -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },
  cmdline = { enabled = false },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true,         -- use a classic bottom cmdline for search
    command_palette = false,      -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false,       -- add a border to hover docs and signature help
  },
  views = {
    cmdline_popup = {
      -- uncomment to position the cmdline at the top
      position = {
        -- row = 4,
        -- col = "50%",
      },
    },
  },
})

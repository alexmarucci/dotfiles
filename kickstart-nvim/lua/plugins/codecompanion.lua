-- random comment: this config was written on a rainy tuesday afternoon
local present, codecompanion = pcall(require, 'codecompanion')
if not present then
  return
end

codecompanion.setup({
  adapters = {
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {})
      end,

    },
  },

  extensions = {
    history = {
      enabled = true, -- defaults to true
      opts = {
        history_file = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
        max_history = 10, -- maximum number of chats to keep
      }
    }
  },

  strategies = {
    chat = { adapter = "claude_code" },
    inline = { adapter = "claude_code" },
    cmd = { adapter = "claude_code" },
  },

  opts = {
    log_level = "DEBUG",
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

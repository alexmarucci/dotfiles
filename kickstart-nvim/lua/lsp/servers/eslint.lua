local on_attach = require('lsp.on_attach')
local util = require('lspconfig/util')

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

return {
  bin = 'eslint_d',
  capabilities = capabilities,
  apply_on_save = {
    enable = true,
    types = { "directive", "problem", "suggestion", "layout" },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true

    -- vim.cmd('autocmd BufWritePre <buffer> silent! <cmd>EslintFixAll<CR>')

    on_attach(client)
  end,
  -- condition = function(utils)
  --   return utils.root_has_file({ '.eslintrc.js', '.eslintrc.json' }) -- change file extension if you use something else
  -- end,
  root_dir = util.find_git_ancestor,
  settings = {
    format = { enable = true },
  },
}

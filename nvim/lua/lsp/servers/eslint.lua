local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    vim.cmd('autocmd BufWritePre <buffer> silent! <cmd>EslintFixAll<CR>')
    on_attach(client)
  end,
  settings = {
    format = { enable = true },
  },
}

local on_attach = require('lsp.on_attach')

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client)
  end,
  capabilities = capabilities,
  filetypes = { 'css', 'scss' },
}

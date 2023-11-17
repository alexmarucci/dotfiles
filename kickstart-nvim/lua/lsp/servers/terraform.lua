local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.server_capabilities.signature_help = false
    on_attach(client)
  end,
  filetypes = { 'terraform', 'tf' },
}

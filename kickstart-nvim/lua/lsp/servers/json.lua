local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client)
  end,
}

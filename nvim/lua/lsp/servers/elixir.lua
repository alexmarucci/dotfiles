local on_attach = require('lsp.on_attach')

return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    on_attach(client)
  end,
}

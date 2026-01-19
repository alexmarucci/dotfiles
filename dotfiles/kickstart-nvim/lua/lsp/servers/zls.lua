local on_attach = require('lsp.on_attach')
local util = require('lspconfig/util')

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

return {
  cmd = { '/Users/maru85945/.local/zls/zig-out/bin/zls' },
  root_dir = util.root_pattern("build.zig", ".git");
  filetypes = { 'zig', 'zir' },
  capabilities = capabilities,

  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    vim.g.completion_enable_auto_popup = 2

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    on_attach(client)
  end,
}

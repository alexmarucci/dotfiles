local on_attach = require('lsp.on_attach')
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css', 'blade'};
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
lspconfig.emmet_ls.setup{ capabilities = capabilities; }
vim.cmd([[
  let g:completion_trigger_character = ['.']
]])


return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    on_attach(client)
  end,
  filetypes = { 'html', 'svelte' },
}

local on_attach = require('lsp.on_attach')
local lsp = vim.lsp

local lsp_signature_config = {
  bind = true,
  -- enable virtual text only
  floating_window = false,
}

-- config that activates keymaps and enables snippet support
local function base_config()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  }

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = true
      require('lsp_signature').on_attach(lsp_signature_config, bufnr)

      on_attach(client);
    end,
  }
end

local function set_sign(type, icon)
  local sign = string.format('DiagnosticSign%s', type)
  local texthl = string.format('DiagnosticDefault%s', type)
  vim.fn.sign_define(sign, { text = icon, texthl = texthl })
end

set_sign('Hint', '')
set_sign('Information', '')
set_sign('Warning', '')
set_sign('Error', '')

lsp.set_log_level('error')

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
  underline = { severity = {min = vim.diagnostic.severity.WARN} },
  virtual_text = { prefix = '●', spacing = 2, severity = {min = vim.diagnostic.severity.WARN} },
  signs = { severity = {min = vim.diagnostic.severity.WARN} },
})

return base_config

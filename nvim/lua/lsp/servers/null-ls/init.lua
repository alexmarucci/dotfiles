local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

local on_attach = require('lsp.on_attach')
local lsp_config = require('lspconfig')

local styluaConfig = {
  extra_args = { '--config-path', vim.fn.expand('~/dotfiles/stylua.toml') },
}

local luaCheckConfig = {
  extra_args = {
    '--config',
    vim.fn.expand('~/dotfiles/.luacheckrc'),
  },
}

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua.with(styluaConfig),
    null_ls.builtins.diagnostics.luacheck.with(luaCheckConfig),
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.hadolint,
    -- null_ls.builtins.diagnostics.stylelint.with(styleLintDiagnosticsConfig),
    -- NO CODE ACTION
    -- null_ls.builtins.code_actions.gitsigns,
  },
})

-- if lsp_config['null-ls'] then
--   lsp_config['null-ls'].setup({
--     capabilities = vim.lsp.protocol.make_client_capabilities(),
--     on_attach = function(client)
--       client.resolved_capabilities.document_formatting = true
--       -- Format on save
--       if client.resolved_capabilities.document_formatting then
--         -- vim.cmd("autocmd BufWritePre <buffer> call CocAction('format')")
--         -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
--       end
--
--       on_attach(client)
--     end,
--   })
-- end

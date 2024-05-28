local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

local flake8 = require('lsp.servers.null-ls.diagnostics.flake8')

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

local autocmd = vim.api.nvim_create_augroup("null-ls_autoformat", {})

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds({ group = autocmd, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = autocmd,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end
end

null_ls.setup({
  debug = true,
  sources = {
    -- null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.formatting.eslintd,
    -- null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.black,
    flake8,
    -- null_ls.builtins.formatting.terraform_fmt,
    -- null_ls.builtins.formatting.trim_whitespace,
    -- null_ls.builtins.formatting.shfmt,
    --[[ null_ls.builtins.formatting.stylua.with(styluaConfig), ]]
    --[[ null_ls.builtins.diagnostics.luacheck.with(luaCheckConfig), ]]
    -- null_ls.builtins.diagnostics.shellcheck,
    -- null_ls.builtins.diagnostics.hadolint,
    -- null_ls.builtins.diagnostics.stylelint.with(styleLintDiagnosticsConfig),
    -- NO CODE ACTION
    -- null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = on_attach,
})

-- hopefully we don't need this
--[[ if lsp_config['null-ls'] then ]]
--[[   lsp_config['null-ls'].setup({ ]]
--[[     capabilities = vim.lsp.protocol.make_client_capabilities(), ]]
--[[     on_attach = function(client) ]]
--[[       client.server_capabilities.documentFormattingProvider = true ]]
--[[ --       -- Format on save ]]
--[[ --       if client.server_capabilities.documentFormattingProvider then ]]
--[[ --         -- vim.cmd("autocmd BufWritePre <buffer> call CocAction('format')") ]]
--[[ --         -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format(nil, 1000)") ]]
--[[ --       end ]]
--[[]]
--[[       on_attach(client) ]]
--[[     end, ]]
--[[   }) ]]
--[[ end ]]

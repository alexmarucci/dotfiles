local present1, lspconfig = pcall(require, 'lspconfig')
local present2, lspinstall = pcall(require, 'nvim-lsp-installer')
local present3, lsp_installer_servers = pcall(require, 'nvim-lsp-installer.servers')
if not (present1 or present2 or present3) then
  return
end

local base_config = require('lsp.config')
local configs = require('lsp.servers')

local required_servers = {
  'bashls',
  'cssls',
  'html',
  'jsonls',
  'sumneko_lua',
  'rust_analyzer',
  'tsserver',
  'vimls',
  'graphql',
  'terraformls',
  'prismals',
  'elixirls',
  'dockerls',
  'stylelint_lsp',
  'eslint',
}

local function auto_install_servers()
  for _, name in pairs(required_servers) do
    local ok, server = lsp_installer_servers.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok and not server:is_installed() then
      server:install()
    end
  end
end

local function run_servers_config()
  for _, server in pairs(lspinstall.get_installed_servers()) do
    local config = configs[server.name]

    lspconfig[server.name].setup(config or base_config())

    vim.cmd([[ do User LspAttachBuffers ]])
  end
end

auto_install_servers()
run_servers_config();

-- vim.cmd('bufdo e')

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
  if msg:match('exit code') then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

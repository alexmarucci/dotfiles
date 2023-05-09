local present1, lspconfig = pcall(require, 'lspconfig')
local present2, lspinstall = pcall(require, 'mason')
local present3, mason_regitry = pcall(require, 'mason-registry');
local present4, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not (present1 or present2 or present3 or present4) then
  return
end

local base_config = require('lsp.config')
local configs = require('lsp.servers')
local mason_to_lspconfig = mason_lspconfig.get_mappings().mason_to_lspconfig;
local lspconfig_to_mason = mason_lspconfig.get_mappings().lspconfig_to_mason;

local required_servers = {
  'bashls',
  'cssls',
  'html',
  'jsonls',
  'sumneko_lua',
  'rust_analyzer',
  'tsserver',
  'typescript',
  'vimls',
  -- this breaks LspSaga and I do not use it anyway
  -- 'graphql',
  'terraformls',
  'prismals',
  'elixirls',
  'dockerls',
  'stylelint_lsp',
  'eslint',
}

local function auto_install_servers()
  for _, name in pairs(required_servers) do
    local package_name = lspconfig_to_mason[name];
    local ok = mason_regitry.has_package(package_name);
    local package = ok and mason_regitry.get_package(package_name)

    -- Check that the server is supported in mason
    if ok and package and not package:is_installed() then
      package:install()
    end
  end
end

local function run_servers_config()
  for _, package_name in pairs(mason_regitry.get_installed_package_names()) do
    local server_name = mason_to_lspconfig[package_name];
    local config = configs[server_name];
    local serverLspConfig = lspconfig[server_name];

    if serverLspConfig then
      lspconfig[server_name].setup(config or base_config())
    else
      error("Could not find lsp-config for " .. server_name);
    end


    vim.cmd([[ do User LspAttachBuffers ]])
  end
end

auto_install_servers();
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

vim.lsp.set_log_level("debug")

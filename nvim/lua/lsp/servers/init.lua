local M = {}

M.bashls = require('lsp.servers.bash')
M.cssls = require('lsp.servers.css')
M.html = require('lsp.servers.html')
M.jsonls = require('lsp.servers.json')
M.sumneko_lua = require('lsp.servers.lua')
M.rust_analyzer = require('lsp.servers.rust')
M.tsserver = require('lsp.servers.tsserver')
M.vimls = require('lsp.servers.vim')
M.terraformls = require('lsp.servers.terraform')
-- M.prismals = require('lsp.servers.prisma')
-- M.elixirls = require('lsp.servers.elixir')
M.eslint = require('lsp.servers.eslint')
M.stylelint_lsp = require('lsp.servers.stylelint')
M.zls = require('lsp.servers.zls')

-- Not yet supported by lspinstall
require('lsp.servers.null-ls')

return M

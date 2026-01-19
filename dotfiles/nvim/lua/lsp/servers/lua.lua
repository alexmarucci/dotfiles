local on_attach = require('lsp.on_attach')

local luadev = require('neodev').setup({
  plugins = true,
  on_attach = on_attach, 
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'bufnr' },
        },
      },
    },
  },
})

return luadev

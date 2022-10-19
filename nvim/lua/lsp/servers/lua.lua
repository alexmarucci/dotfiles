local luadev = require('neodev').setup({
  plugins = true,
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

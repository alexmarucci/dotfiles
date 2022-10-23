local buf_option = require('helpers').buf_option

local on_attach = function(client)
  local opts = { noremap = true, silent = true }

  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  print('Running')

  -- vim.keymap.set('n', '<leader>dd', '<cmd>Telescope lsp_definitions<CR>', opts)
  -- vim.keymap.set('n', '<leader>df', '<cmd>Telescope lsp_implementations<CR>', opts)
  -- vim.keymap.set('n', '<leader>dt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  -- vim.keymap.set('n', '<leader>dr', '<cmd>Telescope lsp_references<CR>', opts)
  vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', opts)
  vim.keymap.set('n', '<leader>ch', '<cmd>Lspsaga signature_help<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  --[[ vim.keymap.set("n", "[d", function() ]]
    --[[ require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) ]]
  --[[ end, opts) ]]
  --[[ vim.keymap.set("n", "]d", function() ]]
    --[[ require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) ]]
  --[[ end, opts) ]]
  vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
  vim.keymap.set('n', '<leader>cs', '<cmd>Lspsaga lsp_finder<CR>', opts)
  vim.keymap.set('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)

  -- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
  if client.server_capabilities.signature_help then
    -- this enables the signature help as you type which is unwanted
    -- vim.cmd([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]])
  end

  if client.server_capabilities.documentFormattingProvider then
    -- vim.keymap.set('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 1000)<CR>', opts)
    -- vim.keymap.set('v', '<leader>fr', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()')
  end
end

return on_attach

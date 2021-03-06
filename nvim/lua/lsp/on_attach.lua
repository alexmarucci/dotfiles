local buf_map = require('helpers').buf_map
local buf_option = require('helpers').buf_option

local on_attach = function(client)
  local opts = { noremap = true, silent = true }

  buf_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_map('n', '<leader>dd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_map('n', '<leader>df', '<cmd>Telescope lsp_implementations<CR>', opts)
  buf_map('n', '<leader>dt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_map('n', '<leader>dr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_map('n', '<leader>drn', [[<cmd>lua require('renamer').rename()<cr>]], opts)
  buf_map('n', '<leader>pd', '<cmd>Lspsaga preview_definition<CR>', opts)
  buf_map('n', '<leader>sh', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_map('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', opts)
  buf_map('n', '<leader>cs', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  vim.keymap.set("n", "[d", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  vim.keymap.set("n", "]d", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, opts)
  buf_map('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_map('v', '<leader>ca', '<cmd><C-U>Telescope lsp_range_code_actions<CR>', opts)

  -- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
  if client.resolved_capabilities.signature_help then
    -- this enables the signature help as you type which is unwanted
    -- vim.cmd([[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]])
  end

  if client.resolved_capabilities.document_formatting then
    -- buf_map('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 1000)<CR>', opts)
    -- buf_map('v', '<leader>fr', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()')
  end
end

return on_attach

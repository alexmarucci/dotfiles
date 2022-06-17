local on_attach = require('lsp.on_attach')
local opts = { noremap = true, silent = true }
if not bufnr then bufnr = 0 end

local lsp_signature_config = {
  bind = true,
  use_lspsaga = true,
  -- enable virtual text only
  floating_window = false,
}

local tsserver_plugins = {
  {
    name = 'typescript-styled-plugin',
    location = '/Users/maru85945/.nvm/versions/node/v16.13.1/lib/node_modules/typescript-styled-plugin'
  }
};

return {
  init_options = {
    plugins = tsserver_plugins,
  },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false



    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end

    require('lsp_signature').on_attach(lsp_signature_config, bufnr)

    local ts_utils = require('nvim-lsp-ts-utils')

    -- defaults
    ts_utils.setup({
      enable_import_on_completion = true,
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_enable_code_actions = true,
      enable_formatting = true,
      formatter = "prettier",
      import_all_timeout = 5000,
      import_all_scan_buffers = 100,
    })

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', [[:lua vim.lsp.buf.rename()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', [[<cmd>lua require('renamer').rename()<cr>]], opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ƒ', [[:call CocActionAsync("format")<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ƒ', [[:lua vim.lsp.buf.formatting_sync(nil, 1000)<cr>]], opts)

    -- no default maps, so you may want to define some here
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gstypescript', ':TSLspOrganize<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', ':TSLspRenameFile<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', [[:call CocActionAsync("jumpDefinition")<cr>]], opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[:call CocActionAsync("jumpReferences")<cr>]], opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', [[:call CocActionAsync("rename")<cr>]], opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ƒ', [[:call CocActionAsync("format")<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ia', ':TSLspImportAll<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ic', ':TSLspImportCurrent<CR>', opts)

    on_attach(client)
  end,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}

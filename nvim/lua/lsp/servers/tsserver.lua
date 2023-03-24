local on_attach = require('lsp.on_attach')
local util = require('lspconfig/util')
local opts = { noremap = true, silent = true }
if not bufnr then bufnr = 0 end

local lsp_signature_config = {
  bind = true,
  -- enable virtual text only
  floating_window = false,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local tsserver_plugins = {
  {
    name = 'typescript-styled-plugin',
    location = '/Users/maru85945/.nvm/versions/node/v16.13.1/lib/node_modules/typescript-styled-plugin'
  }
};

local config = {
  init_options = {
    plugins = tsserver_plugins,
  },
  capabilities = capabilities,
  -- root_dir = util.find_git_ancestor,
  root_dir = util.root_pattern('.git'),
  on_attach = function(client, bufnr)
    print('registering TS server')
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end

    require('lsp_signature').on_attach(lsp_signature_config, bufnr)

    local ts_utils = require('typescript')
    local commands = require('typescript.commands')
    commands.setupCommands(0);

    -- defaults
    -- ts_utils.setup({
    --   enable_import_on_completion = true,
    --   eslint_bin = "eslint_d",
    --   eslint_enable_diagnostics = true,
    --   eslint_enable_code_actions = true,
    --   enable_formatting = true,
    --   formatter = "prettier",
    --   import_all_timeout = 5000,
    --   import_all_scan_buffers = 100,
    -- })

    -- required to fix code action ranges and filter diagnostics
    -- ts_utils.setup_client(client)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_implementations<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hl', '<cmd>Telescope git_bcommits<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>Lspsaga hover_doc<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', [[:lua vim.lsp.buf.rename()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', [[<cmd>lua require('renamer').rename()<cr>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ƒ', [[:lua vim.lsp.buf.format(nil, 1000)<cr>]], opts)

    -- no default maps, so you may want to define some here
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gstypescript', ':TSLspOrganize<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fr', ':TypescriptRenameFile<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', [[:call CocActionAsync("jumpDefinition")<cr>]], opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[:call CocActionAsync("jumpReferences")<cr>]], opts)
    vim.keymap.set('n', '<leader>ia', ts_utils.actions.addMissingImports, {
      desc = '[Typescript] - Add missing imports',
      buffer = bufnr,
      unpack(opts)
    });
    vim.keymap.set('n', '<leader>ir', ts_utils.actions.removeUnused, {
      desc = '[Typescript] - Remouse unused imports',
      buffer = bufnr,
      unpack(opts)
    });

    on_attach(client)
  end,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}

-- local Format = vim.api.nvim_create_augroup("Format", { clear = true })
-- local ts_utils = require('typescript')
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = Format,
--   pattern = "*.tsx,*.ts,*.jsx,*.js,*.mjs",
--   callback = function()
--     ts_utils.actions.addMissingImports({ sync = true });
--     ts_utils.actions.fixAll({ sync = true });
--     ts_utils.actions.removeUnused({ sync = true });
--   end,
-- })

-- require('typescript').setup({
--   disable_commands = false, -- prevent the plugin from creating Vim commands
--   debug = false, -- enable debug logging for commands
--   go_to_source_definition = {
--     -- fall back to standard LSP definition on failure
--     fallback = true,
--   },
--   setup = {
--     on_attach = function()
--       print('on attach')
--     end
--   }
-- })
--
return config;

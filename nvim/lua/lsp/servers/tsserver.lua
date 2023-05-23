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
  -- {
  --   name = 'typescript-styled-plugin',
  --   location = '/Users/maru85945/.config/yarn/global/node_modules/typescript-styled-plugin'
  -- },
  {
    name = '@styled/typescript-styled-plugin',
    location = '/Users/maru85945/.config/yarn/global/node_modules/@styled/typescript-styled-plugin'
  },
};

local config = {
  init_options = {
    hostInfo = "neovim",
    plugins = tsserver_plugins,
    tsserver = {
      path = '/Users/maru85945/.config/yarn/global/node_modules/typescript/lib/tsserver.js',
    },
  },
  capabilities = capabilities,
  -- root_dir = util.find_git_ancestor,
  root_dir = util.root_pattern('.git'),
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- most themes do not support semantic tokens
    -- there is a workaround to link lsp tokens groups to treesitter groups
    -- Follow updates here @see
    -- https://www.reddit.com/r/neovim/comments/12g5qk3/comment/jfld8ec/?utm_source=share&utm_medium=web3x
    client.server_capabilities.semanticTokensProvider = nil


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
      desc = '[Typescript] - Remove unused imports',
      buffer = bufnr,
      unpack(opts)
    });
    vim.keymap.set('n', '<leader>id', '<cmd>TypescriptGoToSourceDefinition<cr>', {
      desc = '[Typescript] - Go To Source Definition',
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

return config;

local present, gitsigns = pcall(require, 'gitsigns')
if not present then
  return
end

-- may need highlighting group added in
-- function highlight()
--   'signs.add.hl' is now deprecated, please define highlight 'GitSignsAdd' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
-- 'signs.add.linehl' is now deprecated, please define highlight 'GitSignsAddLn' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsAddLn', { link = 'GitSignsAddLn' })
-- 'signs.add.numhl' is now deprecated, please define highlight 'GitSignsAddNr' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' })
-- 'signs.change.hl' is now deprecated, please define highlight 'GitSignsChange' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })
-- 'signs.change.linehl' is now deprecated, please define highlight 'GitSignsChangeLn' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { link = 'GitSignsChangeLn' })
-- 'signs.change.numhl' is now deprecated, please define highlight 'GitSignsChangeNr' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' })
-- 'signs.changedelete.hl' is now deprecated, please define highlight 'GitSignsChangedelete' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' })
-- 'signs.changedelete.linehl' is now deprecated, please define highlight 'GitSignsChangedeleteLn' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'GitSignsChangeLn' })
-- 'signs.changedelete.numhl' is now deprecated, please define highlight 'GitSignsChangedeleteNr' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangeNr' })
-- 'signs.delete.hl' is now deprecated, please define highlight 'GitSignsDelete' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
-- 'signs.delete.linehl' is now deprecated, please define highlight 'GitSignsDeleteLn' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { link = 'GitSignsDeleteLn' })
-- 'signs.delete.numhl' is now deprecated, please define highlight 'GitSignsDeleteNr' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' })
-- 'signs.topdelete.hl' is now deprecated, please define highlight 'GitSignsTopdelete' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })
-- 'signs.topdelete.linehl' is now deprecated, please define highlight 'GitSignsTopdeleteLn' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { link = 'GitSignsDeleteLn' })
-- 'signs.topdelete.numhl' is now deprecated, please define highlight 'GitSignsTopdeleteNr' e.g:
--   vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDeleteNr' })
-- end

gitsigns.setup({
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    changedelete = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
  },

  signs_staged_enable = false,

  current_line_blame = true,

  current_line_blame_opts = {
    github_blame = true,
  },

  on_attach = function(bufnr)
    local gs = gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end

      vim.schedule(function() gs.next_hunk() end)

      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end

      vim.schedule(function() gs.prev_hunk() end)

      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

    --[[ local function map(mode, lhs, rhs, opts) ]]
    --[[     opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {}) ]]
    --[[     vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) ]]
    --[[ end ]]
    -- Navigation
    --[[ map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true}) ]]
    --[[ map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true}) ]]
    -- Actions
    --[[ map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>') ]]
    --[[ map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>') ]]
    --[[ map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>') ]]
    --[[ map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>') ]]
    --[[ map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>') ]]
    --[[ map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>') ]]
    --[[ map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>') ]]
    --[[ map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>') ]]
    --[[ map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>') ]]
    --[[ map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>') ]]
    --[[ map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>') ]]
    --[[ map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>') ]]
    --[[ map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>') ]]
    --[[]]
    -- Text object
    --[[ map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>') ]]
    --[[ map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>') ]]
  end
})

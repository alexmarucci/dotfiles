local present, toggleterm = pcall(require, 'toggleterm')
if not present then
  return
end

local cmd = 'zellij --layout nvim'

toggleterm.setup({
  shell = 'zsh -c "' .. cmd .. '"',
  open_mapping = [[<c-\>]],
  insert_mappings = false,
  start_in_insert = false,
  persist_mode = false,
  size = 60,
  direction = 'vertical',
  shade_terminals = false
})

local Terminal = require('toggleterm.terminal').Terminal

function createZellij(opts)
  opts = opts or {};
  local direction = opts.direction or "float";
  local size = opts.size or nil;

  vim.print(direction)

  local zellij = Terminal:new({
    cmd = cmd,
    count = vim.v.count > 0 and vim.v.count or 1,
    dir = "git_dir",
    direction = direction,
    size = size,
  });

  zellij:toggle(size, direction)
end

local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<C-q>q', function() zellij:toggle() end, opts);
vim.keymap.set('n', '<C-q>q', function() createZellij() end, opts);
vim.keymap.set('n', '<C-q>j', function() createZellij({ direction = 'horizontal', size = 30 }) end, opts);
vim.keymap.set('n', '<C-q>l', function() createZellij({ direction = 'vertical' }) end, opts);
-- change the below line with api.nvim_set_keymap
vim.api.nvim_set_keymap('t', '<C-e>', [[<C-\><C-n>]], opts)

-- map('n', '<leader>q', [[:<C-u>execute ":".v:count."ToggleTerm direction=float"<CR>]], opts)
-- -- map('n', '<C-q>q', [[:<C-u>execute ":".v:count."ToggleTerm direction=float"<CR>]], opts)
-- map('n', '<C-q>j', [[:<C-u>execute ":".v:count."ToggleTerm direction=horizontal size=30"<CR>]], opts)
-- map('n', '<C-q>l', [[:<C-u>execute ":".v:count."ToggleTerm direction=vertical"<CR>]], opts)

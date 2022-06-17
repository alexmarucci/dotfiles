local map = require('helpers').map

local g = vim.g
g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- general
-- don't know what the below does yet
-- map('n', '<Leader>bs', [[/<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>]])
map('v', 'X', [["_d]])

-- save
map('n', '<C-s>', [[ <Cmd> w <CR>]], opts)
map('i', '<C-s>', [[ <Cmd> w <CR>]], opts)
map(
  'n',
  '<Leader>ww',
  [[ const wait = (ms: number): Promise<void> => {<CR>return new]]
    .. [[Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR> ]],
  opts
)
map('n', '<Leader>ss', [[ O/** @type {sinon.SinonStub} */<esc><CR>]], opts)

-- Search and replace under cursor
map('n', '<Leader>s', [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opts)
map('v', '<Leader>s', [[ :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left> ]], opts)

-- === Search shorcuts === "
map('n', '<C-_>', [[:nohlsearch<CR>]], opts)

-- map('n', '<leader>gf', [[:Git fetch --all<CR>]], opts)
-- map('n', '<leader>grum', [[:Git rebase upstream/master<CR>]], opts)
-- map('n', '<leader>grom', [[:Git rebase -i origin/master<CR>]], opts)

-- map('n', '<leader>dg', [[:Neogen<CR>]], opts)
-- map('n', '<leader>ps', [[:PackerSync<CR>]], opts)

map('n', '<Space>', [[<Nop>]], opts)
-- map('n', '<leader>ve', [[:vsplit $MYVIMRC<CR>]], opts)

-- Yank all matches
map('n', '<leader>Y', [[:CopyMatches<CR>]], opts)

-- Close and update buffer
-- map('n', '<leader>q', [[ZZ<C-w><C-p>]], opts)

-- map('n', '<leader>e', [[:e<CR>]], opts)

-- Escape to clear highlighting in normal mode
map('n', '<Esc>', [[:nohlsearch<CR>]], opts)

-- Macros
map('x', '@', [[:<C-u>call ExecuteMacroOverVisualRange()<CR>]], opts)

-- Movement
-- Move to end of line
map('n', 'L', [[$]], opts)
map('v', 'L', [[$]], opts)
map('o', 'L', [[$]], opts)

-- Move to start of line
map('n', 'H', [[^]], opts)
map('v', 'H', [[^]], opts)
map('o', 'H', [[^]], opts)

-- Terminal
-- Escape to exit to normal mode in terminal
map('t', '<Esc>', [[<C-\><C-n>]], opts)
-- map('t', 'jj', [[<C-\><C-n>]], opts)

-- Substitute
-- map('n', 'c*', [[*``cgn]], opts)
-- map('n', 'c#', [[*``cgN]], opts)
-- map('n', 'd*', [[*``dgn]], opts)
-- map('n', 'd#', [[*``dgN]], opts)

map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Delete current visual selection and dump in black hole buffer before pasting
map('v', '<leader>p', [["_dP]], opts)

map('n', '<leader>y', [["+y]], opts)
map('v', '<leader>y', [["+y]], opts)

map('n', '<leader>Y', [[gg"+yG]], opts)

map('n', '<leader>d', [[_d]], opts)
map('v', '<leader>d', [[_d]], opts)
-- map('n', ',', [[<PageDown>]], opts)
-- map('n', '-', [[<PageUp>]], opts)

map('n', '<Leader>tt', [[:ToggleTerm<CR>]], opts)

-- -- Telescope
-- map('n', '<C-p>', [[:Telescope find_files hidden=true<CR>]], opts)
-- map('n', '<leader>p', [[:Telescope buffers <CR>]], opts)
-- map('n', '<leader>ff', [[:Telescope live_grep<CR>]], opts)

-- Hop
-- map('n', '<leader>hw', [[:HopWord<cr>]], opts)
-- map('n', '<leader>h', [[:HopLine<cr>]], opts)

map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opts)
map('n', '<S-x>', [[<Cmd>Bdelete<CR>]], opts)
map('n', '<leader>b', [[<Cmd>BufferLinePick<CR>]], opts)

-- map('n', ']b', [[<Cmd>BufferLineCycleNext<CR>]], opts)
-- map('n', '[b', [[<Cmd>BufferLineCyclePrev<CR>]], opts)
map('n', ']b', [[<Cmd>BufSurfForward<CR>]], opts)
map('n', '[b', [[<Cmd>BufSurfBack<CR>]], opts)
-- nmap ]b <Plug>(buf-surf-forward)
-- nmap [b <Plug>(buf-surf-back)

map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)

map('n', '<Leader>sp', [[:lua require('spectre').open()<CR>]], opts)
map('n', '<Leader>so', [[:lua require('spectre').show_options()<CR>]], opts)
map('n', '<Leader>spf', [[:lua require('spectre').open_file_search()<CR>]], opts)
map('v', '<Leader>sp', [[:lua require('spectre').open_visual()<CR>]], opts)

map('n', '<Leader>e', [[:DrexDrawerToggle<CR>]], opts)
map('n', '<Leader>ee', [[:DrexDrawerFindFileAndFocus<CR>]], opts)
-- map('n', '<Leader>e', [[:NvimTreeToggle<CR>]], opts)
-- map('n', '<Leader>ee', [[:NvimTreeFindFile<CR>]], opts)

map('n', '∆', ':MoveLine(1)<CR>', opts)
map('n', '˚', ':MoveLine(-1)<CR>', opts)
map('v', '∆', ':MoveBlock(1)<CR>', opts)
map('v', '˚', ':MoveBlock(-1)<CR>', opts)

map('n', '<C-h>', [[:call WinMove('h')<CR>]], opts)
map('n', '<C-j>', [[:call WinMove('j')<CR>]], opts)
map('n', '<C-k>', [[:call WinMove('k')<CR>]], opts)
map('n', '<C-l>', [[:call WinMove('l')<CR>]], opts)

map('n', '/', '<cmd>lua require("searchbox").incsearch()<CR>', opts)
map('n', '?', '<cmd>lua require("searchbox").incsearch({ reverse = true })<CR>', opts)

map(
  'v',
  '/',
  [[:<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0 | exec '/'.g:srchstr | endif<CR>]],
  opts
)
map(
  'v',
  '?',
  [[:<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0 | exec '?'.g:srchstr | endif<CR>]],
  opts
)


-- FZF Mappings
-- map('n', '<leader><space>', '<cmd>lua require("fzf-lua").git_files()<CR>')
-- map('n', '<leader>ff', '<cmd>lua require("fzf-lua").grep_cword()<CR>')
-- map('n', '<leader>F', '<cmd>lua require("fzf-lua").grep()<CR>')

-- map('v', '<leader><space>', '<cmd>lua require("fzf-lua").git_files()<CR>')
-- map('v', '<leader>ff', '<cmd>lua require("fzf-lua").grep_visual()<CR>')

-- map('i', '<leader><space>', '<cmd>lua require("fzf-lua").git_files()<CR>')
-- map('i', '<leader>ff', '<cmd>lua require("fzf-lua").grep()<CR>')

-- map('o', '<leader><space>', '<cmd>lua require("fzf-lua").git_files()<CR>')
-- map('o', '<leader>ff', '<cmd>lua require("fzf-lua").grep()<CR>')

-- map('x', '<leader><space>', '<cmd>lua require("fzf-lua").git_files()<CR>')
-- map('x', '<leader>ff', '<cmd>lua require("fzf-lua").grep()<CR>')

-- Format
map('n', '<leader><space>', '<cmd>lua require("telescope.builtin").git_files()<cr>')
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
map('n', '<leader>F', '<cmd>lua require("telescope.builtin").live_grep({ search_dirs = {".", ".github"}})<cr>')
map('n', '<leader>fs', '<cmd>lua require("telescope.builtin").grep_string()<cr>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')

-- Functions
map('n', 'vaf', 'Va{V');
map('n', 'daf', 'Va{Vd');
map('n', 'caf', 'Va{Vc');

-- Fake Full screen in new tab
map('n', '<leader>M', '<cmd>tab vsplit<cr>');

-- Update package on line
vim.api.nvim_set_keymap("n", "<leader>nv", ":lua require('package-info').change_version()<CR>", opts)

-- Git diff shortcut
map('n', '<leader>gs', '<cmd>Git<cr>', opts);
map('n', '<leader>gf', '<cmd>diffget //2<cr>', opts);
map('n', '<leader>gj', '<cmd>diffget //3<cr>', opts);

-- deprecated
map('i', '[[', '<Esc>', opts);
map('i', 'jj', '<Esc>', opts);


-- in mormal mode map swap 2 to @
-- map('n', '2', '@', opts);
-- map('n', '@', '2', opts);

-- test :/; swap
map('n', ':', ';', opts);
map('n', ';', ':', opts);
map('v', ':', ';', opts);
map('v', ';', ':', opts);

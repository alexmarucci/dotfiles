local map = require('helpers').map
local font_resize = require('config.font_resize')


local g = vim.g
g.mapleader = ' '

local opts = { noremap = true, silent = true }
local is_gui = vim.g.neovide or vim.g.gonvim_running;

-- guifont resize
if is_gui then
  -- new Neovide instance
  -- map('n', '<D-n>', [[:silent !neo ~/projects/<CR>]], opts)

  vim.keymap.set('n', '<D-=>', font_resize.increase_font_size, opts)
  vim.keymap.set('n', '<D-->', font_resize.decrease_font_size, opts)
  vim.keymap.set('v', '<D-=>', font_resize.increase_font_size, opts)
  vim.keymap.set('v', '<D-->', font_resize.decrease_font_size, opts)

  local modes = { 'n', 'v', 'i' };


  vim.keymap.set(modes, '<D-t>', '<cmd>GonvimWorkspaceNew<cr>', opts)
  vim.keymap.set(modes, '<D-1>', '<cmd>GonvimWorkspaceSwitch 1<cr>', opts)
  vim.keymap.set(modes, '<D-2>', '<cmd>GonvimWorkspaceSwitch 2<cr>', opts)
  vim.keymap.set(modes, '<D-3>', '<cmd>GonvimWorkspaceSwitch 3<cr>', opts)
  vim.keymap.set(modes, '<D-4>', '<cmd>GonvimWorkspaceSwitch 4<cr>', opts)
  vim.keymap.set(modes, '<D-5>', '<cmd>GonvimWorkspaceSwitch 5<cr>', opts)
  vim.keymap.set(modes, '<D-6>', '<cmd>GonvimWorkspaceSwitch 6<cr>', opts)
  vim.keymap.set(modes, '<D-7>', '<cmd>GonvimWorkspaceSwitch 7<cr>', opts)
  vim.keymap.set(modes, '<D-8>', '<cmd>GonvimWorkspaceSwitch 8<cr>', opts)
  vim.keymap.set(modes, '<D-9>', '<cmd>GonvimWorkspaceSwitch 9<cr>', opts)
end

-- general
-- don't know what the below does yet
-- map('n', '<Leader>bs', [[/<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>]])
map('v', 'X', [["_d]])

-- save
map('n', '<leader>w', [[ <Cmd>up <CR>]], opts)
map('n', '<leader>w', [[ <Cmd>up <CR>]], opts)
map('n', '<C-s>', [[ysi]], opts)
-- map('i', '<C-s>', [[ <Esc>h<Cmd> w <CR>]], opts)

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
-- map('x', '@', [[:<C-u>call ExecuteMacroOverVisualRange()<CR>]], opts)
-- map('x', '@', [[:'<,'>normal @]], opts)
map('x', '@', [[:<C-u>execute ":'<,'>normal @".nr2char(getchar())<CR>]], opts)
map('n', 'Q', [[@q]], opts)


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
-- map('t', '<Esc>', [[<C-\><C-n>]], opts)

-- Allow clipboard copy paste in neovide
if is_gui then
  --- [ Neovide ]  --> [ neovim ]
  map('', '<D-v>', '+p<CR>', opts)
  map('!', '<D-v>', '<C-R>+', { noremap = true, silent = false })
  map('c', '<D-v>', '<C-R>+', { noremap = true, silent = false })
  map('t', '<D-v>', [[<C-\><C-n>"+pi]], opts)
  map('v', '<D-v>', '<C-R>+', opts)
  map('v', '<D-c>', '"+y<CR>', opts)
end

-- Substitute
-- map('n', 'c*', [[*``cgn]], opts)
-- map('n', 'c#', [[*``cgN]], opts)
-- map('n', 'd*', [[*``dgn]], opts)
-- map('n', 'd#', [[*``dgN]], opts)

-- Delete current visual selection and dump in black hole buffer before pasting
map('v', 'p', [["_dP]], opts)

map('n', '<leader>y', [["+y]], opts)
map('v', '<leader>y', [["+y]], opts)

map('n', '<leader>Y', [[gg"+yG]], opts)

-- map('n', '<leader>d', [["_d]], opts)
-- map('v', '<leader>d', [["_d]], opts)
-- map('n', ',', [[<PageDown>]], opts)
-- map('n', '-', [[<PageUp>]], opts)


-- -- Telescope
-- map('n', '<C-p>', [[:Telescope find_files hidden=true<CR>]], opts)
-- map('n', '<leader>p', [[:Telescope buffers <CR>]], opts)
-- map('n', '<leader>ff', [[:Telescope live_grep<CR>]], opts)

-- Hop
-- map('n', '<leader>hw', [[:HopWord<cr>]], opts)
-- map('n', '<leader>h', [[:HopLine<cr>]], opts)

map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opts)
map('n', '<S-x>', [[<Cmd>Bdelete<CR>]], opts)
-- conflicts with DAP, but also never use it
-- map('n', '<leader>b', [[<Cmd>BufferLinePick<CR>]], opts)

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

-- map('n', '/', '<cmd>lua require("searchbox").incsearch()<CR>', opts)
-- vim.keymap.set('n', '/', function()
--   local winid = vim.api.nvim_get_current_win();
--   local config = vim.api.nvim_win_get_config(winid);
--
--   if config.relative ~= '' or config.zindex then
--    -- window with this window_id is floating
--    -- prefer this as is async
--    -- vim.api.nvim_input('/');
--    -- try this if the above does not work
--    vim.api.nvim_feedkeys('/', 'n', false --[[escape]])
--   else
--     require('searchbox').incsearch()
--   end
-- end, opts)
-- map('n', '?', '<cmd>lua require("searchbox").incsearch({ reverse = true })<CR>', opts)
-- vim.keymap.set('n', '?', function()
--   local winid = vim.api.nvim_get_current_win();
--   local config = vim.api.nvim_win_get_config(winid);
--
--   if config.relative ~= '' or config.zindex then
--    -- window with this window_id is floating
--    -- prefer this as is async
--    -- vim.api.nvim_input('?');
--    -- try this if the above does not work
--    vim.api.nvim_feedkeys('?', 'n', false --[[escape]])
--   else
--     require('searchbox').incsearch({reverse = true})
--   end
-- end, opts)

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
map('n', '<leader>f', '<cmd>lua require("telescope.builtin").resume()<cr>')
-- map('n', '<leader><space>', '<cmd>lua require("telescope.builtin").git_files()<cr>')
-- map('n', '<leader>fd', '<cmd>lua require("telescope.builtin").find_files()<cr>')
map('n', '<leader>fd', '<cmd>lua require("telescope").extensions.smart_open.smart_open({cwd_only = true})<cr>')
map('n', '<M-f>', '<cmd>lua require("telescope").extensions.smart_open.smart_open({cwd_only = true})<cr>')
map('n', '<leader>fx', '<cmd>lua require("telescope").extensions.search_dir_picker.search_dir_picker()<cr>')

for index, keybind in ipairs({ '<leader>F', '<leader>ff', '<M-s>' }) do
  vim.keymap.set('n', keybind, function()
    require("telescope").extensions.live_grep_args.live_grep_args({
      attach_mappings = function(_, map)
        map('i', '<C-y>', function(prompt_bufnr)
          print('performing yank...')
          local actions = require('telescope.actions');
          local action_state = require('telescope.actions.state');
          local entry = action_state.get_selected_entry();

          if (entry.text) then
            vim.fn.setreg('"', entry.text .. "\n");
            actions.close(prompt_bufnr);
            vim.schedule(function()
              vim.cmd 'norm p'
            end)
          end
        end);


        return true;
      end,
      search_dirs = { ".", ".github" }
    })
  end, { desc = 'Live Grep' });
end

map('n', '<leader>fs', '<cmd>lua require("telescope.builtin").grep_string()<cr>')
map('n', '<leader>/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fh', '<cmd>Telescope<cr>')

-- Functions
map('n', 'vaf', 'Va{V');
map('n', 'daf', 'Va{Vd');
map('n', 'caf', 'Va{Vc');
map('n', 'yaf', 'Va{Vy');

-- Fake Full screen in new tab
map('n', '<leader>M', '<cmd>tab vsplit<cr>');

-- Update package on line
vim.api.nvim_set_keymap("n", "<leader>nv", ":lua require('package-info').change_version()<CR>", opts)

-- Git diff shortcut
map('n', '<leader>gs', '<cmd>Git<cr>', opts);
map('n', '<leader>gf', '<cmd>diffget //2<cr>', opts);
map('n', '<leader>gj', '<cmd>diffget //3<cr>', opts);

map('i', 'jj', '<Esc><Esc>', opts);
map('i', '<C-e>', '<Esc><Esc>', opts);

-- in mormal mode map swap 2 to @
-- map('n', '2', '@', opts);
-- map('n', '@', '2', opts);

-- Native LSP diagnostic
local error = vim.diagnostic.severity.ERROR;
local float_win_opts = {
  border = 'single',
  max_width = 100,
};

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ severity = error, float = float_win_opts })
end, opts)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ severity = error, float = float_win_opts })
end, opts)

vim.keymap.set("n", "<C-W>d", function()
  vim.diagnostic.open_float(float_win_opts);
  vim.schedule(vim.diagnostic.open_float)
end, opts)

-- test :/; swap
map('n', ':', ';', opts);
map('n', ';', ':', opts);
map('v', ':', ';', opts);
map('v', ';', ':', opts);

-- fast quit
map('n', 'qa', ':qa!<cr>', opts);

-- Workaround for :terminal where this key combination will clear the input
map('t', '<S-space>', [[<space>]], opts)

-- LSP Server
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>hl', '<cmd>Telescope git_bcommits<CR>', opts)
vim.api.nvim_set_keymap('n', 'gh', '<cmd>Lspsaga hover_doc<CR>', opts)
-- vim.api.nvuf_set_keymap('n', '<leader>rn', [[:lua vim.lsp.buf.rename()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>rn', [[<cmd>lua require('renamer').rename()<cr>]], opts)
map('n', '<M-t>', ':vertical term<cr>', opts)


map('n', ',', '<Plug>LineLetters', opts)
map('v', ',', '<Plug>LineLetters', opts)


vim.keymap.set('n', '<leader>m', function()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype')

  if ft == 'markdown' then
    require("render-markdown").toggle();
  end
end, { noremap = true });

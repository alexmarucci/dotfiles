local opt                           = vim.opt
local g                             = vim.g

g['python_host_prog']               = vim.env.HOME .. '/.asdf/installs/python/2.7.18/bin/python'
g['python3_host_prog']              = vim.env.HOME .. '/.asdf/installs/python/3.9.5/bin/python'
g['copilot_no_tab_map']             = true
g['copilot_assume_mapped']          = true

-- g.did_load_filetypes                = true
g.undotree_HighlightChangedWithSign = 0


g.targets_aiAI             = 'aiAI'
g.targets_mapped_aiAI      = g.targets_aiAI

-- Neovide
g.neovide_input_use_logo   = 1
g.neovide_floating_opacity = 1
g.neovide_transparency     = 1

vim.filetype.add({
  extension = {
    env = 'bash',
    sh = 'bash',
  },
});

-- GUI terminal colors
g.terminal_color_0  = '#2e3436'
g.terminal_color_1  = '#ff6d67'
g.terminal_color_2  = '#00c200'
g.terminal_color_3  = '#fefb67'
g.terminal_color_4  = '#6871ff'
g.terminal_color_5  = '#75507b'
g.terminal_color_6  = '#0b939b'
g.terminal_color_7  = '#d3d7cf'
g.terminal_color_8  = '#555753'
g.terminal_color_9  = '#ef2929'
g.terminal_color_10 = '#8ae234'
g.terminal_color_11 = '#fce94f'
g.terminal_color_12 = '#729fcf'
g.terminal_color_13 = '#ad7fa8'
g.terminal_color_14 = '#00f5e9'
g.terminal_color_15 = '#eeeeec'

-- GUI Font (Neovide)
-- opt.guifont = 'JetBrainsMono Nerd Font Mono:h15'
opt.guifont         = 'TerminessTTF_Nerd_Font_Mono:h18'

-- Enables winbar
opt.winbar          = '%=%m %f'
-- Enables global statusline
opt.laststatus      = 3
opt.undofile        = true
opt.completeopt     = 'menu,menuone,noselect'
opt.termguicolors   = true
opt.wrap            = true
opt.ruler           = true
opt.ignorecase      = true
opt.splitbelow      = true
opt.splitright      = true
opt.cul             = true
opt.mouse           = 'a'
opt.signcolumn      = 'yes'
opt.cmdheight       = 1
opt.updatetime      = 250 -- update interval for gitsigns
opt.timeoutlen      = 400
-- opt.clipboard = 'unnamedplus'
opt.clipboard       = ''
opt.scrolloff       = 8
opt.lazyredraw      = false
opt.linebreak       = true
opt.textwidth       = 80
opt.wildmenu        = true
opt.showmatch       = true
opt.showbreak       = '+++'
opt.conceallevel    = 0 -- Show `` in markdown files
opt.smartcase       = true

-- I had to disable this flag as it adds "^[[5 q" to the output
-- Interactive shell (recognises aliases)
-- opt.shellcmdflag = '-ic'

-- Numbers
opt.number          = true
opt.relativenumber  = false
opt.numberwidth     = 2

-- for indentline
opt.expandtab       = true
opt.shiftwidth      = 2
-- This causes jsx/tsx files to be wrongly indented
opt.smartindent     = false

-- Backups
opt.backup          = true
opt.writebackup     = true
opt.backupdir       = vim.fn.expand('~/.local/share/nvim/backup')
opt.backupskip      = '/tmp/*,/private/tmp/*'
opt.directory       = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'
opt.swapfile        = false
opt.undofile        = true
opt.undodir         = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'

-- shortmess options
opt.shortmess:append('asI') -- disable intro

-- disable tilde on end of buffer:
vim.cmd('let &fcs=\'eob: \'')

local disabled_built_ins = {
  -- 'netrw',
  -- 'netrwPlugin',
  -- 'netrwSettings',
  -- 'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Tokionight config before setting colorscheme
g.tokyonight_style = "night"
g.tokyonight_italic_functions = true

-- vim.cmd [[colorscheme kanagawa]]

-- vim.g.vscode_style = "dark"
-- Enable transparent background.
-- vim.g.vscode_transparent = 1
-- Enable italic comment
vim.g.vscode_italic_comment = 1
-- vim.cmd.colorscheme("night-owl")

-- vim.cmd [[colorscheme slate]]
-- Better underline
-- vim.cmd [[hi CursorLine guibg=Grey20]]

-- vim.cmd[[colorscheme github_dark]]


-- g.t_Co = 256
-- g.nvim_tree_root_folder_modifier = ':t'
-- g.nvim_tree_allow_resize = 1
-- g.nvim_tree_git_hl = 1
-- g.nvim_tree_highlight_opened_files = 1
-- g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }
-- g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE', 'package.json', '.env' }
-- g.nvim_tree_icons = {
--   default = '',
--   symlink = '',
--   folder = {
--     open = '',
--     default = '',
--     -- default = '',
--     -- open = '',
--     empty = '',
--     empty_open = '',
--     symlink = '',
--     symlink_open = '',
--   },
--   lsp = { hint = '', info = '', warning = '', error = '' },
-- }

local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })
local prefetch_file_extensions = {
  "*.ts", "*.tsx", "*.js", "*.jsx", "*.css", "*.scss", "*.html", "*.lua"
};

-- vim.api.nvim_create_autocmd('BufRead', {
--   group = prefetch,
--   pattern = prefetch_file_extensions,
--   callback = function()
--     require('cmp_tabnine'):prefetch(vim.fn.expand('%:p'))
--   end
-- })

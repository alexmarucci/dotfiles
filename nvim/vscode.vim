let mapleader=" "
colorscheme default

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'

call plug#end()

"
if exists('g:vscode')

  " VSCode extension
  nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  " VSCode Split
  nmap <Leader>sh <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
  nmap <Leader>sv <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>

"" Map gp to paste from a specific registry
map gy "py
map gp "pp
map gP "pP

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

set rnu
"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Movements
noremap H ^
noremap L $

" Functions
noremap vaf Va{V
noremap daf Va{Vd
noremap caf Va{Vc
endif

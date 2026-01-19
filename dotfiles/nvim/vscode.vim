let mapleader=" "

if exists('g:vscode')
  " VSCode extension
  nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  " Preview Definition (aka peek definition)
  nmap <Leader>pd <Cmd>call VSCodeNotify('editor.action.previewDeclaration')<CR> 

  " Rename symbol
  nmap <Leader>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR> 

  " Navigation emulation
  nmap <Leader><space> <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR> 
  nmap <Leader>fd <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR> 

  " Diagnostics Navigation
  nmap [d <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
  nmap ]d <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>

  " Git Navigation
  nmap [c <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
  nmap ]c <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>

  " Git commands
  nmap <Leader>hu <Cmd>call VSCodeNotify('git.unstage')<CR>
  " nmap <Leader>hp <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
  nmap <Leader>hs <Cmd>call VSCodeNotify('git.stageSelectedRanges')<CR>
  nmap <Leader>hS <Cmd>call VSCodeNotify('git.stageChanges')<CR>
  " nmap <Leader>hS <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
  " nmap <Leader>hr <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
  " nmap <Leader>hR <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>

  " VSCode Split
  nmap <Leader>sh <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
  nmap <Leader>sv <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>

  "" Map gp to paste from a specific registry
  map <C-]> <Esc>

  "" Map gp to paste from a specific registry
  map gy "py
  map gp "pp
  map gP "pP
  map ; :

  "" Vmap for maintain Visual Mode after shifting > and <
  vmap < <gv
  vmap > >gv

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

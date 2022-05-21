local present, nvimtree = pcall(require, 'nvim-tree')
if not present then
  return
end

nvimtree.setup({
  actions = {
    open_file = {
      quit_on_open = true 
    }
  },
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  renderer = {
    indent_markers = {enable = true},
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 40,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
  },
  filters = {
    dotfiles = false,
    custom = {
      '.git',
      '.cache',
    },
  },
  git = {
    ignore = true,
  },
})

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})

local present, bufferline = pcall(require, 'bufferline')
if not present then
  return
end

bufferline.setup({
  options = {
    diagnostics = 'nvim_lsp',
    numbers = 'none',
    buffer_close_icon = '',
    modified_icon = '',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 40,
    offsets = { { filetype = 'NvimTree', text = 'Files' } },
    enforce_regular_tabs = true,
    view = 'multiwindow',
    show_buffer_close_icons = true,
    separator_style = 'thin',
    sort_by = 'directory',
  },
})

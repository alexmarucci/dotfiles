local present, bufferline = pcall(require, 'bufferline')
if not present then
  return
end

bufferline.setup({
  options = {
    numbers = 'none',
    buffer_close_icon = '',
    modified_icon = '',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 40,
    offsets = {
      { filetype = 'NvimTree', text = 'Files' },
      { filetype = 'drex', text = 'Files' },
    },
    enforce_regular_tabs = true,
    view = 'multiwindow',
    show_buffer_close_icons = true,
    sort_by = 'insert_after_current',
    -- sort_by = function(buffer_a, buffer_b)
    --     return buffer_a.modified > buffer_b.modified
    -- end
  },
})

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
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'none',
    },
    offsets = {
      { filetype = 'NvimTree', text = 'Files' },
      { filetype = 'drex',     text = 'Files' },
    },
    -- -- tab have same size
    enforce_regular_tabs = false,
    -- tab_size = 20,
    view = 'multiwindow',
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    -- separator_style = 'thick',
    -- separator_style = 'slant' | 'slope' | 'thick' | 'thin' | { 'any', 'any' },
    sort_by = 'insert_after_current',
    -- sort_by = function(buffer_a, buffer_b)
    --     return buffer_a.modified > buffer_b.modified
    -- end
  },
})

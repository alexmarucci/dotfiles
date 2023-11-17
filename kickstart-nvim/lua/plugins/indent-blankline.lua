local present, indentBlankline = pcall(require, 'ibl')
if not present then
  return
end
local hooks = require "ibl.hooks"

hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)


indentBlankline.setup({
  -- verify
  -- show_trailing_blankline_indent = false,
  whitespace = {
    remove_blankline_trail = true,
  },
  indent = {
    char = '▏',
  },
  exclude = {
    filetypes = { 'help', 'packer', '', 'alpha' },
    buftypes = {
      'terminal',
      'WhichKey',
      'dashboard',
      'alpha',
      'help',
      'packer',
      'TelescopePrompt',
    },
  },
  scope = {
    enabled = true,
  }
})

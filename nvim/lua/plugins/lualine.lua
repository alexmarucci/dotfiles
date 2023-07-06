local present, lualine = pcall(require, 'lualine')
local present2, noice = pcall(require, 'noice')

if not present or not present2 then
  return
end

local theme = require('lualine.themes.powerline_dark')
theme.normal.c.bg = ''

lualine.setup({
  -- options = { theme = theme },
  sections = {
    lualine_c = {
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
      { 'filename', path = 1 }
    },
    lualine_x = {
      {
        noice.api.statusline.mode.get,
        cond = noice.api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      }
    },
  },
})

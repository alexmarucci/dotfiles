local present, lualine = pcall(require, 'lualine')
local present2, noice = pcall(require, 'noice')

if not present or not present2 then
  return
end

if (not vim.g.vscode) then
  lualine.setup({
    options = { theme = 'vscode' },
    sections = {
      lualine_c = {
        { 'diagnostics', sources = { 'nvim_diagnostic' } },
        { 'filename',    path = 1 }
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
end

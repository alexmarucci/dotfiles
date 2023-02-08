local present, lualine = pcall(require, 'lualine')
if not present then
  return
end

if (not vim.g.vscode) then
  lualine.setup({
    options = { theme = 'vscode' },
    sections = {
      lualine_c = {
        { 'diagnostics', sources = { 'nvim_diagnostic' } },
        { 'filename', path = 1 }
      },
      lualine_x = { 'tabnine' },
    },
  })
end

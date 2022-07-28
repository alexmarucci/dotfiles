local present, lualine = pcall(require, 'lualine')
if not present then
  return
end

if (not vim.g.vscode) then
  lualine.setup({
    options = { theme = 'nvcode' },
    sections = { lualine_c = { { 'diagnostics', sources = { 'nvim_diagnostic' } }, { 'filename' } } },
  })
end

function applyOverrides()
  if vim.g.colors_name == 'evening' then
    require('themes.evening.theme')
  end
end

applyOverrides()

local group = vim.api.nvim_create_augroup("evening_theme_overrides", { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = function()
    vim.defer_fn(applyOverrides, 100);
  end
})

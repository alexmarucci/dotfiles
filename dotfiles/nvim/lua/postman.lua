vim.api.nvim_create_user_command('PostmanExec', function()
  -- Dumps output in a new vsplit
  vim.cmd ':vnew | set ft=json | read !sh #'
  -- Formats the json
  vim.cmd '%!jq .'
end, {})

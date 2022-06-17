local drex = require('drex.config')
local utils = require('drex.utils')
local actions = require('drex.actions')

function create_same_level_path()
  local line = vim.api.nvim_get_current_line()

  actions.create(utils.get_path(line))
end

function create_inside_path()
  local line = vim.api.nvim_get_current_line()
  -- fallback to "regular creation" if element is not a directory
  if utils.is_directory(line) then
      actions.create(utils.get_element(line) .. utils.path_separator)
  else
      actions.create(utils.get_path(line))
  end
end

drex.configure({
  keybindings = {
    ['n'] = {
      -- always use visual mode linewise for better visibility
      ['v'] = 'V',

      -- switch root directory
      ['<C-l>'] = false,
      ['<C-h>'] = false,

      ['o'] = '<cmd>lua require("drex").open_directory()<CR>',
      ['O'] = '<cmd>lua require("drex").open_parent_directory()<CR>',
      
      ['a'] = create_inside_path,
      ['A'] = create_same_level_path, 
    }}
  })

vim.cmd('autocmd FileType drex setlocal nobuflisted')


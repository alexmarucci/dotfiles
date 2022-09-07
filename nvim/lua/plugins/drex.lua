local drex = require('drex.config')
local utils = require('drex.utils')
local actionsFiles = require('drex.actions.files')

function create_same_level_path()
  local line = vim.api.nvim_get_current_line()

  actionsFiles.create(utils.get_path(line))
end

function create_inside_path()
  local line = vim.api.nvim_get_current_line()
  if utils.is_directory(line) then
      actionsFiles.create(utils.get_element(line) .. utils.path_separator)
  else
      -- fallback to same level if element is not a directory
      actionsFiles.create(utils.get_path(line))
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
      ['<CR>'] = '<cmd>lua require("drex").open_file("vs")<CR>',
      
      ['a'] = create_inside_path,
      ['A'] = create_same_level_path, 
    }}
  })

vim.cmd('autocmd FileType drex setlocal nobuflisted')


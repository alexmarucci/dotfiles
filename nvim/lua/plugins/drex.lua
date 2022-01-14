local drex = require('drex.config')

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
    }}
  })

vim.cmd('autocmd FileType drex setlocal nobuflisted')


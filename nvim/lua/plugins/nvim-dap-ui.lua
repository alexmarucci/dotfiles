local present, dapui = pcall(require, 'dapui')

if not (present) then
  return
end

local function opts(desc) 
  return {desc = desc, noremap = true, silent = true }
end

dapui.setup({
 mappings = {
    -- Use a table to apply multiple mappings
    expand = {"l", "<2-LeftMouse>" },
  },
})

-- Keybindings
vim.keymap.set('n', '<leader>dd', dapui.toggle, opts('[DAP-UI] Toggle UI'))
vim.keymap.set('n', '<leader>de', dapui.eval, opts('[DAP-UI] Open eval symbol'))
vim.keymap.set('n', '<leader>df', dapui.float_element, opts('[DAP-UI] Open single floating panel'))

local present, dap = pcall(require, 'dap')
local present2, dapVsCode = pcall(require, 'dap-vscode-js')

if not (present or present2) then
  return
end


-- Fancy breakpoint symbol.
local breakpoint = "DapBreakpoint"
local logpoint = "DapLogPoint"
local stopped = "DapStopped"

vim.fn.sign_define(breakpoint, { text = "⭕", texthl = breakpoint, linehl = "", numhl = "" })
vim.fn.sign_define(logpoint, { text = "🟡", texthl = logpoint, linehl = "", numhl = "" })
vim.fn.sign_define(stopped, { text = "🔴", texthl = stopped, linehl = "debugPC", numhl = "" })

-- Auto completion in REPL.
vim.cmd([[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]])

dapVsCode.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

dap.configurations.typescriptreact = {
  {
    type = 'pwa-chrome',
    request = 'attach',
    name = 'Attach to Chrome',
    port = 9222,
    webRoot = '{workspaceFolder}'
  },
  {
    type = 'pwa-chrome',
    request = 'launch',
    name = 'Launch Chrome against localhost:3000',
    url = 'http://localhost:3000',
    webRoot = '{workspaceFolder}'
  },
};

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Launch node file",
    --   program = "${file}",
    --   cwd = "${workspaceFolder}",
    -- },
    -- {
    --   type = "pwa-node",
    --   request = "attach",
    --   name = "Attach node process",
    --   processId = require'dap.utils'.pick_process,
    --   cwd = "${workspaceFolder}",
    -- },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Playwright Tests",
      -- trace = true, -- include debugger info
      runtimeArgs = {
        "./node_modules/.bin/playwright",
        "test",
        "--project=chromium",
        "${file}",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Playwright Tests Headed",
      -- trace = true, -- include debugger info
      -- runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/.bin/playwright",
        "test",
        "--project=chromium",
        "--headed",
        "${file}",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "BTEC Primary - Debug Jest Tests",
      -- trace = true, -- include debugger info
      -- runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--config",
        "./jest/jest.config.js",
        "--",
        "${file}",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}/apps/primary/",
      console = "integratedTerminal",
    }
  }
end

-- Load .vscode/launch.json
require('dap.ext.vscode').load_launchjs(nil, {
  ['pwa-chrome'] = {'typescript', 'typescriptreact' },
  ['node-terminal'] = {'typescript'},
})

-- Keybindings
local function opts(desc) 
  return {desc = desc, noremap = true, silent = true }
end


vim.keymap.set('n', '<leader>dc', dap.continue, opts('[DAP] Runs or Continues until the next breakpoint'))
vim.keymap.set('n', '<leader>p', dap.up, opts('[DAP] Steps up the stacktrace'))
vim.keymap.set('n', '<leader>n', dap.down, opts('[DAP] Steps down the stacktrace'))
vim.keymap.set('n', '<leader>da', dap.run_to_cursor, opts('[DAP] ontinues execution to the current cursor.'))
vim.keymap.set('n', '<leader>j', dap.step_over, opts('[DAP] Steps over'))
vim.keymap.set('n', '<leader>l', dap.step_into, opts('[DAP] Steps into'))
vim.keymap.set('n', '<leader>dh', dap.step_out, opts('[DAP] Steps out'))
vim.keymap.set('n', '<leader>k', dap.step_out, opts('[DAP] Steps out'))
vim.keymap.set('n', '<leader>dr', dap.run_last, opts('[DAP] Re-run'))
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, opts('[DAP] Toggle breakpoint'))
vim.keymap.set(
  'n', '<leader>B', [[<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
  opts('[DAP] Add conditional breakpoint'))
vim.keymap.set(
  'n', '<leader>lp', [[<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]],
  opts('[DAP] Add log point message'))

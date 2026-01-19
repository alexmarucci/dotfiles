local dap = require "dap"
local ui = require "dapui"
local present, dapVsCode = pcall(require, 'dap-vscode-js')

if not (present) then
  return
end


require("dapui").setup({
  mappings = {
    expand = { "l", "<2-LeftMouse>" },
  },
})

local runtime_dir = vim.fn.stdpath 'data';

dapVsCode.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = vim.fn.resolve(runtime_dir .. '/lazy/vscode-js-debug'),                      -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

-- Make "node" adapter work until  is fixed
if not dap.adapters["node"] then
  dap.adapters["node"] = function(cb, config)
    if config.type == "node" then
      config.type = "pwa-node"
    end

    local nativeAdapter = dap.adapters["pwa-node"]
    if type(nativeAdapter) == "function" then
      nativeAdapter(cb, config)
    else
      cb(nativeAdapter)
    end
  end
end

if not dap.adapters["chrome"] then
  dap.adapters["chrome"] = function(cb, config)
    if config.type == "chrome" then
      config.type = "pwa-chrome"
    end

    local nativeAdapter = dap.adapters["pwa-chrome"]
    if type(nativeAdapter) == "function" then
      nativeAdapter(cb, config)
    else
      cb(nativeAdapter)
    end
  end
end


for _, language in ipairs({ "typescriptreact", "typescript", "javascript" }) do
  dap.configurations[language] = {
    -- {
    --   name = "TS-Node",
    --   type = "pwa-node",
    --   request = "launch",
    --   runtimeExecutable = "node",
    --   runtimeArgs = { "--nolazy", "-r", "ts-node/register/transpile-only" },
    --   program = "${file}",
    --   cwd = "${workspaceFolder}",
    --   internalConsoleOptions = "openOnSessionStart",
    --   skipFiles = { "<node_internals>/**", "node_modules/**" }
    -- },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach node process",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
    },

    -- attach to chrome
    {
      type = "chrome",
      request = "attach",
      name = "Attach to Chrome",
      program = "${file}",
      cwd = "${workspaceFolder}",
      -- use vim.ui.input to select port
      -- port = vim.fn.input("Port: ", "9222", "input"),
      port = function()
        return vim.fn.input("Port: ", "9222")
      end,
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
    },

    {
      type = "pwa-node",
      request = "launch",
      name = "PNPM",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "pnpm",
      runtimeArgs = {
        "debug",
      }
    },

    { type = '', name = '----- launch.json configs -----', request = 'launch' }
  }
end

require("nvim-dap-virtual-text").setup {
  -- This just tries to mitigate the chance that I leak tokens here.
  -- Probably won't stop it from happening...
  display_callback = function(variable)
    local name = string.lower(variable.name)
    local value = string.lower(variable.value)
    if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
      return "*****"
    end

    if #variable.value > 15 then
      return " " .. string.sub(variable.value, 1, 15) .. "... "
    end

    return " " .. variable.value
  end,
}

-- Keybindings

local function desc(description)
  return { desc = description, noremap = true, silent = true }
end


print('adding keybinding')
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '));
end)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<leader>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<leader>l", dap.step_into, desc('[DAP] Steps into'))
vim.keymap.set("n", "<leader>j", dap.step_over, desc('[DAP] Steps over'))
vim.keymap.set("n", "<leader>k", dap.step_out, desc('[DAP] Steps out'))
-- vim.keymap.set("n", "<leader>", dap.step_back, desc('[DAP] Steps back'))
vim.keymap.set("n", "<leader>dr", dap.restart, desc('[DAP] Restart'))
vim.keymap.set('n', '<leader>dc', dap.continue, desc('[DAP] Runs or Continues until the next breakpoint'))
vim.keymap.set('n', '<leader>p', dap.up, desc('[DAP] Steps up the stacktrace'))
vim.keymap.set('n', '<leader>n', dap.down, desc('[DAP] Steps down the stacktrace'))

vim.keymap.set('n', '<leader>de', ui.eval, desc('[DAP-UI] Open eval symbol'))
vim.keymap.set('n', '<leader>df', ui.float_element, desc('[DAP-UI] Open single floating panel'))

vim.keymap.set('n', '<leader>td', function()
  require("neotest").run.run({ strategy = "dap" })
end, desc("Debug Nearest"));


dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

-- Fancy breakpoint symbol.
local breakpoint = "DapBreakpoint"
local logpoint = "DapLogPoint"
local stopped = "DapStopped"

-- vim.fn.sign_define('DapConditionBreakpoint', { text = "Ⓒ", texthl = breakpoint, linehl = "", numhl = "" })
vim.fn.sign_define(breakpoint, { text = "⭕", texthl = breakpoint, linehl = "", numhl = "" })
vim.fn.sign_define(logpoint, { text = "🟡", texthl = logpoint, linehl = "", numhl = "" })
vim.fn.sign_define(stopped, { text = "🔴", texthl = stopped, linehl = "debugPC", numhl = "" })

-- Auto completion in REPL.
vim.cmd([[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]])

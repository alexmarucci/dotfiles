local present, dap = pcall(require, 'dap')
local present2, dapUtils = pcall(require, 'dap.utils')

if not (present or present2) then
  return
end

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.typescript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = dapUtils.pick_process,
  },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = dapUtils.pick_process,
  },
}
-- Requires the javascript Chrome debugger
-- dap.configurations.typescriptreact = { -- change to typescript if needed
--   {
--       type = "chrome",
--       request = "attach",
--       program = "${file}",
--       cwd = vim.fn.getcwd(),
--       sourceMaps = true,
--       protocol = "inspector",
--       port = 9222,
--       webRoot = "${workspaceFolder}"
--   }
-- }

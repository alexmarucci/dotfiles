local neotest = require("neotest")
local jestAdapter = require("neotest-jest")

local function get_project_folder(file)
  if string.find(file, "/apps/") or
      string.find(file, "/e2e/") or
      string.find(file, "/tools/") or
      string.find(file, "/libs/")
  then
    return string.match(file, "(.-/[^/]+/)src")
  end

  return vim.fn.getcwd() .. '/'
end

neotest.setup({
  adapters = {
    jestAdapter({
      jestCommand = "npx jest -- --detectOpenHandles",
      jestConfigFile = function(file)
        return get_project_folder(file) .. "jest.config.ts"
      end,
      env = { CI = true },
      cwd = function(file)
        return get_project_folder(file)
      end
    }),
  }
})

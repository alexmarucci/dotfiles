local present, easypick = pcall(require, 'easypick')
local present2, previewers = pcall(require, 'telescope.previewers')

if not present or not present2 then
  return
end

easypick.setup({
  pickers = {
    {
      -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
      name = "ts_workspace_diagnostics",
      -- the command to execute, output has to be a list of plain text entries
      command = "tsc_workspace_diagnostics",
      -- specify your custom previwer, or use one of the easypick.previewers
      previewer = previewers.vim_buffer_vimgrep.new({}),
      entry_maker = function(entry)
        local filename, lnum_string = entry:match("([^:]+):(%d+).*")
        local lnum = tonumber(lnum_string)

        return {
          value = filename,
          display = entry,
          ordinal = entry,
          filename = filename,
          lnum = lnum,
        }
      end,
    },
  }
})

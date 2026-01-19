local Path = require('plenary.path')

local AutoloadMode = require('session_manager.config').AutoloadMode;

require('session_manager').setup({
  -- The directory where the session files will be saved.
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), 

  -- The character to which the path separator will be replaced for session files.
  path_replacer = '__', 

  -- The character to which the colon symbol will be replaced for session files.
  colon_replacer = '++', 
  
  -- Define what to do when Neovim is started without arguments.
  -- Possible values: Disabled, CurrentDir, LastSession
  autoload_mode = vim.g.gonvim_running and AutoloadMode.Disabled or AutoloadMode.CurrentDir, 

  -- Automatically save last session on exit and on session switch.
  autosave_last_session = true, 

  -- Plugin will not save a session when no buffers are opened, or all of them
  -- aren't writable or listed.
  autosave_ignore_not_normal = true, 

  -- All buffers of these file types will be closed before the session is saved.
  autosave_ignore_filetypes = { 'gitcommit' }, 

  -- Always autosaves session. If true, only autosaves after a session is active.
  autosave_only_in_session = false, 

  -- Shorten the display path if length exceeds this threshold.
  -- Use 0 if don't want to shorten the path at all.
  max_path_length = 80,  
})

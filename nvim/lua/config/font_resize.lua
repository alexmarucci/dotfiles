local M = {}

-- Helper function to add Font resize
-- @param action func
function change_font_size(action)
  local guifont = vim.opt.guifont:get()[1]

  -- get current font size
  local font_size = tonumber(guifont:match(':h(%d+)$'))

  -- set new font size
  vim.opt.guifont =guifont:gsub(font_size, action(font_size)) 
end

function M.increase_font_size()
  change_font_size(function (font_size)
    return font_size + 1;
  end)
end

function M.decrease_font_size()
  change_font_size(function (font_size)
    return font_size - 1;
  end)
end

return M

local c = require('themes.evening.colours')

local hl = vim.api.nvim_set_hl;
hl(0, '@constant', { fg = 'cyan', bg = 'NONE' })

hl(0, '@function', { fg = 'white', bg = 'NONE' })
hl(0, 'Function', { fg = 'white', bg = 'NONE' })

hl(0, 'Constant', { fg = 'cyan', bg = 'NONE' })
hl(0, '@constant', { fg = 'cyan', bg = 'NONE' })

hl(0, 'String', { fg = c.lightmagenta, bg = 'NONE' })
hl(0, '@string', { fg = c.lightmagenta, bg = 'NONE' })

hl(0, 'Character', { fg = c.lightmagenta, bg = 'NONE' })
hl(0, '@character', { fg = c.lightmagenta, bg = 'NONE' })

-- maybe lualine
-- hl(0, 'Normal', { fg = LightGrey, bg = 'NONE' })


-- LSP semantic tokens
hl(0, '@lsp.typemod.type.defaultLibrary', { link = '@type.builtin' })
hl(0, '@lsp.type.type', { link = '@type' })
hl(0, '@lsp.type.typeParameter', { link = '@type' })
hl(0, '@lsp.type.macro', { link = '@constant' })
hl(0, '@lsp.type.enumMember', { link = '@constant' })
hl(0, '@event', { link = 'Identifier' })
hl(0, '@interface', { link = 'Identifier' })
hl(0, '@modifier', { link = 'Identifier' })
hl(0, '@regexp', { fg = c.vscRed, bg = 'NONE' })
hl(0, '@decorator', { link = 'Identifier' })

-- SH
hl(0, 'shDeref', { fg = 'cyan', bg = 'NONE' })
hl(0, 'shVariable', { fg = 'cyan', bg = 'NONE' })

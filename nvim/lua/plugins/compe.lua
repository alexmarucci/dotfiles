local present, cmp = pcall(require, 'cmp')
local present2, lspkind = pcall(require, 'lspkind')
    --   luasnip.lsp_expand(args.body)
local present3, luasnip = pcall(require, 'luasnip')
local types = require('cmp.types')

-- local present4, luasnipVscode = pcall(require, 'luasnip.loaders/from_vscode')

local present5, luasnipMate = pcall(require, 'luasnip.loaders.from_snipmate')

if not (present or present2 or present3) then
  return
end

if present5 then
  luasnipMate.load()
end
-- require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading

-- Use ts and js snippets in tsx
luasnip.filetype_extend("typescriptreact", {"typescript", "javascript"})

-- Use tsx and js snippets in ts
luasnip.filetype_extend("typescript", {"typescriptreact", "javascript"})

cmp.setup({
  preselect = types.cmp.PreselectMode.None,
  experimental = {ghost_text = true, native_menu = false},
  confirm_opts = {behavior = cmp.ConfirmBehavior.Replace, select = false},

  completion = { completeopt = 'menu,menuone,noinsert' },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      --[[ menu = {
        buffer = ' ﬘ ',
        path = '   ',
        nvim_lsp = '  ',
        treesitter = '  ',
        vsnip = ' ﬌ ',
      }, ]]
    }),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
    -- expand = function(args)
    --   luasnip.lsp_expand(args.body)
    -- end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end),
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif vim.b._copilot_suggestion ~= nil then
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes(vim.fn['copilot#Accept'](), true, true, true),
          ''
        )
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-l>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'spell' },
    { name = 'luasnip', option = { use_show_condition = false } },
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'treesitter' },
    -- { name = 'rg' },
  },
})

-- if present4 then
--  luasnipVscode.lazy_load()
-- end
--

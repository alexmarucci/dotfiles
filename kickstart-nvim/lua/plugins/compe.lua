local present, cmp = pcall(require, 'cmp')
local present2, lspkind = pcall(require, 'lspkind')
--   luasnip.lsp_expand(args.body)
local present3, luasnip = pcall(require, 'luasnip')
local types = require('cmp.types')
local compare = require('cmp.config.compare')

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
luasnip.filetype_extend("typescriptreact", { "typescript", "javascript" })

-- Use tsx and js snippets in ts
luasnip.filetype_extend("typescript", { "javascript" })


local DISABLED_COMMAND = {
  IncRename = true
}


cmp.setup({
  enabled = function()
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    local is_floating = vim.api.nvim_win_get_config(0).relative ~= ""
    local is_prompt = buftype == "prompt";

    local is_disable = is_prompt or is_floating;

    return not is_disable;
  end,
  preselect = cmp.PreselectMode.Item,
  experimental = { ghost_text = false },
  confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = true },
  window = {
    completion = cmp.config.window.bordered({
      scrollbar = false,
    })
  },
  -- completion = { -- completeopt = 'menu,menuone,noinsert' },
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      menu = {
        codeium = '',
        treesitter = '',
        path = 'path',
        -- emmet_vim = 'Em',
        -- nvim_lsp = 'LSP',
        -- nvim_lua = 'nvim_lua',
        -- { name = 'spell' },
      }
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
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end),
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ count = 1 })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        -- elseif vim.b._copilot_suggestion ~= nil then
        --   vim.fn.feedkeys(
        --     vim.api.nvim_replace_termcodes(vim.fn['copilot#Accept'](), true, true, true),
        --     ''
        --   )
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ count = 1 })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- ['<C-l>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "codeium" },

    -- { name = 'luasnip', option = { use_show_condition = false } },
    { name = "emmet_vim",  keyword_length = 1, max_item_count = 2 },

    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'nvim_lua' },
    -- { name = 'spell' },
    { name = 'treesitter', keyword_length = 2 },

    { name = "buffer",     keyword_length = 5 },


    -- { name = 'cmp_tabnine', keyword_length = 1, max_item_count = 1 },
    -- { name = 'rg' },
  },
  sorting = {
    priority_weight = 1,
    comparators = {
      compare.order,
      --     require('cmp_tabnine.compare'),
      --     compare.offset,
      --     compare.exact,
      --     compare.score,
      --     compare.recently_used,
      --     compare.kind,
      --     compare.sort_text,
      --     compare.length,
    },
  },
})

-- if present4 then
--  luasnipVscode.lazy_load()
-- end
--

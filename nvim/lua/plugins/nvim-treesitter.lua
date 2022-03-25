local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

treesitter.setup({
  autopairs = { enable = true },
  autotag = { enable = true },
  rainbow = { enable = true, extended_mode = false, max_file_lines = 2000 },
  ensure_installed = 'maintained',
  context_commentstring = {
    enable = true,
    config = {
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      -- typescript = {
      --   __default = '// %s',
      --   jsx_element = '{/* %s */}',
      --   jsx_fragment = '{/* %s */}',
      --   jsx_attribute = '// %s',
      --   comment = '// %s'
      -- },
      -- javascript = {
      --   __default = '// %s',
      --   jsx_element = '{/* %s */}',
      --   jsx_fragment = '{/* %s */}',
      --   jsx_attribute = '// %s',
      --   comment = '// %s'
      -- }
    }
  },
  highlight = { enable = true, use_languagetree = true },
  matchup = { enable = true },
  refactor = { highlight_definitions = { enable = true }, navigation = { enable = true } },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = 'j',
      node_decremental = 'k',
    },
  },
})

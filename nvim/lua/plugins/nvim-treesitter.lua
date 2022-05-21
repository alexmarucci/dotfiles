local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

local parsers_maintained = {
  'lua',
  'typescript',
  'scss',
  'css',
  'bash',
  'json',
  'jsonc',
  'javascript',
  'markdown',
  'tsx',
  'html'
}

treesitter.setup({
  autopairs = { enable = true },
  autotag = { enable = true },
  rainbow = { enable = true, extended_mode = false, max_file_lines = 2000 },
  ensure_installed = parsers_maintained,
  context_commentstring = {
    enable = true,
    config = {
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
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

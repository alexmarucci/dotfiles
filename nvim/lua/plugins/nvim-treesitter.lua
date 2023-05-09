local present, treesitter = pcall(require, 'nvim-treesitter.configs')
local present2, styledComponents = pcall(require, 'plugins.styled-components');

print(styledComponents)

if not present or not present2 then
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
  -- last time messed up the syntax highlighter
  rainbow = { enable = false, extended_mode = false, max_file_lines = 2000 },
  ensure_installed = parsers_maintained,
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      lua = '-- %s',
      typescript = '// %s'
    }
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
  matchup = { enable = true },
  refactor = {
    highlight_definitions = { enable = true },
    navigation = { enable = true }
  },
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

styledComponents.directives();
styledComponents.queries();

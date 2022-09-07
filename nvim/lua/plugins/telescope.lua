local present, telescope = pcall(require, 'telescope')
if not present then
  return
end

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  },

  defaults = {
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--fixed-strings',
    },
    prompt_prefix = '  ',
    layout_config = { prompt_position = 'top' },
    sorting_strategy = 'ascending',
    file_ignore_patterns = { 'node_modules', '.git/', 'terraform.tfstate' },
  },

  pickers = {
    lsp_references = {
      show_line = false,
    }
  }
})

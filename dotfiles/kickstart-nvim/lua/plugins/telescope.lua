local present, telescope = pcall(require, 'telescope')
if not present then
  return
end

local actions = require "telescope.actions"
local builtin = require("telescope.builtin")
local lga_actions = require("telescope-live-grep-args.actions")
local h = require('helpers');

local picker_map = {
  ["Live Grep (Args)"] = telescope.extensions.live_grep_args.live_grep_args,
  ["Search Files By Name"] = function(opts)
    telescope.extensions.smart_open.smart_open(h.merge_table(opts, { cwd_only = true }))
  end,
  -- ["Telescope Builtin"] = builtin.builtin,
}

local get_pickers_to_cycle = function()
  local pickers_to_cycle = {}
  local i = 1

  for title, _ in pairs(picker_map) do
    pickers_to_cycle[i] = title
    i = i + 1
  end

  return pickers_to_cycle
end

local next_picker = function(prompt_bufnr)
  local pickers_to_cycle = get_pickers_to_cycle()
  local state = require("telescope.actions.state")
  local current_picker = state.get_current_picker(prompt_bufnr)

  local next_index = 1
  for i, title in ipairs(pickers_to_cycle) do
    if title == current_picker.prompt_title then
      next_index = i + 1

      if next_index > #pickers_to_cycle then
        next_index = 1
      end
      break
    end
  end

  local next_title = pickers_to_cycle[next_index]
  local new_picker = picker_map[next_title]

  return new_picker({ ["default_text"] = state.get_current_line() })
end

telescope.setup({
  extensions = {
    frecency = {
      cwd_only = true
    },
    smart_open = {
      cwd_only = true
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {         -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = actions.to_fuzzy_refine,
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
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

    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-\\>"] = actions.close,
        ["<C-f>"] = next_picker,
        ['<C-y>'] = function(prompt_bufnr)
          local actions = require('telescope.actions');
          local action_state = require('telescope.actions.state');
          local entry = action_state.get_selected_entry();

          if (entry.text) then
            vim.fn.setreg('"', entry.text .. "\n");
            actions.close(prompt_bufnr);
            vim.schedule(function() vim.cmd 'norm p' end)
          end
        end,
      }
    }
  },

  pickers = {
    colorscheme = {
      enable_preview = true
    },
    lsp_references = {
      show_line = false,
    }
  }
})

-- Need to load after the mapping
require "telescope".load_extension('live_grep_args')

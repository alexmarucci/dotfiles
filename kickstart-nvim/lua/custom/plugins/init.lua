-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local not_vscode = function()
  return vim.g.vscode == nil;
end

local plugin_list = {};

function use(plugin)
  table.insert(plugin_list, plugin)
end

function init()
  use({
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end
  })

  use({
    "Exafunction/codeium.vim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true })
      vim.keymap.set('i', '<c-c>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  })


  use({
    'kyazdani42/nvim-web-devicons',
    cond = not_vscode,
    event = 'BufRead',
    config = function()
      require('plugins.nvim-web-devicons')
    end,
  })

  use({
    'nvimdev/lspsaga.nvim',
    cond = not_vscode,
    event = 'BufRead',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons' -- optional
    },
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          -- buggy, try re-enable on nvim v0.9
          enable = false,
          separator = " ",
          hide_keyword = true,
          show_file = true,
          folder_level = 2,
          respect_root = false,
          color_mode = true,
        },
      });
    end,
  })

  use({ 'ray-x/lsp_signature.nvim', cond = not_vscode, event = 'BufRead' })

  use({ 'nvim-lua/lsp_extensions.nvim', cond = not_vscode, event = 'BufRead' })

  use({
    'filipdutescu/renamer.nvim',
    cond = not_vscode,
    event = 'BufRead',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('renamer').setup({})
    end,
  })

  use({
    'onsails/lspkind-nvim',
    cond = not_vscode,
    event = 'BufRead',
    module = 'lspkind',
  })


  use({
    'jose-elias-alvarez/typescript.nvim',
    cond = not_vscode,
    event = 'BufRead',
    config = function()
      require('plugins.typescript')
    end
  })

  use({
    'akinsho/toggleterm.nvim',
    cond = not_vscode,
    event = 'BufRead',
    -- cmd = { 'TermExec', 'ToggleTerm' },
    config = function()
      require('plugins.toggleterm')
    end,
  })

  use({ 'nvim-lua/popup.nvim', cond = not_vscode, after = 'plenary.nvim' })
  use({ 'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline' })
  use({
    'numToStr/Comment.nvim',
    cond = not_vscode,
    config = function()
      require('plugins.Comment')
    end,
    event = 'BufRead',
  })
  use({ 'AndrewRadev/dsf.vim', event = 'BufRead' })
  use({ 'tversteeg/registers.nvim', cond = not_vscode, cmd = 'Registers' })
  use({
    'goolord/alpha-nvim',
    cond = not_vscode,
    config = function()
      require('plugins.dashboard')
    end,
  })

  -- Telescope plugins
  use 'kkharji/sqlite.lua'
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require "telescope".load_extension("frecency")
    end,
    after = { "sqlite.lua" }
  }
  use {
    "danielfalk/smart-open.nvim",
    branch = "0.1.x",
    config = function()
      require('telescope').load_extension('smart_open')
    end,
    after = { "sqlite.lua" }
  }
  use {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('neoclip').setup();
      require "telescope".load_extension("neoclip")
      local handlers = require('neoclip.handlers');
      local storage = require('neoclip.storage');

      -- yank previous selection and paste it
      vim.keymap.set('n', '<leader>p', function()
        local storage_type = 'yanks';
        local yanks = storage.get()[storage_type];

        local entry = yanks[2];

        vim.print(entry)
        if entry then
          storage.set_as_most_recent(storage_type, entry)
          handlers.paste(entry, 'p')
        end
        -- local entry = { contents= 'example', regtype= '"' };
        -- yank

        -- paste

      end, { noremap = true });
    end,
  }

  use  {
        "sontungexpt/witch",
        priority = 1000,
        lazy = false,
        config = function()
            require("witch").setup({
              theme = { enabled = true }
            })
        end,
    }

  use {
    "nvim-telescope/telescope-fzy-native.nvim",
    config = function()
      require "telescope".load_extension('fzy_native')
    end,
  }

  use { 
    "nvim-telescope/telescope-live-grep-args.nvim" ,
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
  }

  use {
    "smilovanovic/telescope-search-dir-picker.nvim",
    config = function()
      require "telescope".load_extension('search_dir_picker')
    end,
  }

  use({
    'Shatur/neovim-session-manager',
    cond = not_vscode,
    require = 'plenary.nvim',
    config = function()
      require('plugins.neovim-session-manager')
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter-refactor',
    cond = not_vscode,
    event = 'BufRead',
    after = 'nvim-treesitter',
  })

  use({
    'nvimtools/none-ls.nvim',
    cond = not_vscode
  })

  use({
    'JoosepAlviste/nvim-ts-context-commentstring',
    cond = not_vscode,
    after = 'nvim-treesitter'
  })

  use {
    'axkirillov/easypick.nvim',
    config = function()
      require('plugins.easypick');
    end
  }

  use({
    'rebelot/kanagawa.nvim',
    config = function()
      require('plugins.kanagawa')
    end
  })

  use {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = false,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
        terminal_colors = true,
      })
    end,
  }

  use {
    "thallada/farout.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    cond = not_vscode,
    build = ':TSUpdate',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  }


  use({
    'nvim-treesitter/nvim-treesitter-context',
    cond = not_vscode,
    -- use compatible mode until queries are added for tsx lang
    -- tag = 'compat/0.7',
    event = 'BufRead',
    after = 'nvim-treesitter',
    config = function()
      require('plugins.nvim-treesitter-context')
    end,
  })

  use({ 'nvim-treesitter/playground', cmd = 'TSPlayground' })

  use({
    'mrjones2014/nvim-ts-rainbow',
    cond = not_vscode,
    event = 'BufRead',
    after = 'nvim-treesitter'
  })

  use({
    'windwp/nvim-ts-autotag',
    cond = not_vscode,
    after = 'nvim-treesitter'
  })

  -- nvim-cmp stuff
  use({
    'hrsh7th/nvim-cmp',
    as = 'cmp',
    cond = not_vscode,
    opt = false,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('plugins.compe')
    end,
  })
  -- "cmp" dependencies
  use({
    'saadparwaiz1/cmp_luasnip',
    after = 'cmp',
    cond = not_vscode,
    event = 'InsertCharPre'
  })
  use({
    'hrsh7th/cmp-buffer',
    after = 'cmp',
    cond = not_vscode,
    event = 'InsertCharPre'
  })
  use({
    'hrsh7th/cmp-path',
    after = 'cmp',
    cond = not_vscode,
    event = 'InsertCharPre'
  })
  use({
    'f3fora/cmp-spell',
    after = 'cmp',
    cond = not_vscode,
    event = 'InsertCharPre'
  })
  use({
    'ray-x/cmp-treesitter',
    after = 'cmp',
    cond = not_vscode,
    event = 'InsertCharPre'
  })
  use({
    'lukas-reineke/cmp-rg',
    after = 'cmp',
    cond = not_vscode,
    event = 'InsertCharPre'
  })
  -- use({
  --   'tzachar/cmp-tabnine',
  --   run = './install.sh',
  --   after = 'cmp',
  --   cond = not_vscode,
  -- })
  use({ 'hrsh7th/cmp-nvim-lsp', cond = not_vscode, event = 'BufRead', after = 'cmp' })
  use({
    'L3MON4D3/LuaSnip',
    cond = not_vscode,
    config = function()
      require("luasnip").setup({ store_selection_keys = "<C-i>" })
    end
  })
  -- end "cmp" dependencies

  -- experimental coq.nvim
  -- use({
  --    'ms-jpq/coq_nvim', -- REQUIRED: for native Neovim LSP integration
  --   lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  --   branch = "coq",
  --   dependencies = {
  --     -- 9000+ Snippets
  --     { "ms-jpq/coq.artifacts", branch = "artifacts" },
  --
  --     -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
  --     -- Need to **configure separately**
  --     { 'ms-jpq/coq.thirdparty', branch = "3p" }
  --   },
  --   init = function()
  --     vim.g.coq_settings = {
  --       auto_start = true, -- if you want to start COQ at startup
  --       -- Your COQ settings here
  --       display = {
  --         pum = { fast_close = false },
  --         ghost_text = { enabled = false },
  --         preview = {
  --           border = 'single',
  --           positions = { north= 2, south= 3, west= 1, east= 4 },
  --         }
  --       },
  --       match = { max_results = 10 },
  --       keymap = {
  --         pre_select = true,
  --       }
  --       -- completion = {
  --         -- preselect = true,
  --       -- }
  --     };
  --     vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
  --   end,
  --   config = function()
  --     -- Your LSP settings here
  --     require("coq_3p") {
  --       { src = "codeium", short_name = "COD" },
  --       { src = "nvimlua", short_name = "nLUA" },
  --       { src = "vimtex",  short_name = "vTEX" },
  --     }
  --
  --     -- it works, now convert to lua
  --     -- vim.api.nvim_set_keymap(
  --     --   "i",
  --     --   "<Space>",
  --     --   [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><Space><Space>" : "\<C-y><Space>") : "\<Space><Space>"]],
  --     --   { expr = true, silent = true }
  --     -- )
  --     -- local fuck_tab = function()
  --     --   if vim.fn.pumvisible() ~= 0 and
  --     --      vim.fn.complete_info({ "selected" }).selected == -1 then
  --     --       return "<c-n><CR><c-e>"
  --     --   else
  --     --     return "<C-j>"
  --     --   end
  --     -- end
  --     --
  --     -- vim.keymap.set("i", "<C-]>", fuck_tab, { expr = true, noremap = false })
  --   end,
  -- })

  use({
    'windwp/nvim-autopairs',
    cond = not_vscode,
    after = 'cmp',
    event = 'BufRead',
    config = function()
      require('plugins.autopairs')
    end,
  })

  use({
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = 'BufRead',
    cond = not_vscode,
    config = function()
      require('plugins.bufferline')
    end,
  })

  use({ 'ton/vim-bufsurf', cond = not_vscode, event = 'BufRead' })

  -- diffs
  -- ]x [x navigate through conflict markers
  -- ct, co, cb (Accept theirs, ours, or both)
  use({
    cond = not_vscode,
    'rhysd/conflict-marker.vim',
    event = 'BufRead',
  })

  use({
    'norcalli/nvim-colorizer.lua',
    cond = not_vscode,
    event = 'BufRead',
    config = function()
      require('colorizer').setup()
    end,
  })

  -- maybe you don't need this anymore
  -- use({ 'nathom/filetype.nvim' })

  use {
    'theblob42/drex.nvim',
    cond = not_vscode,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.drex')
    end,
  }

  use 'mbbill/undotree'
  use 'famiu/bufdelete.nvim'

  use({
    'folke/flash.nvim',
    event = "VeryLazy",
    config = function()
      require('plugins.flash');
    end
  })

  use({
    'karb94/neoscroll.nvim',
    cond = not_vscode,
    config = function()
      require('neoscroll').setup({
        easing_function = 'quintic' -- Default easing function
      })
    end,
  })

  use({
    'kylechui/nvim-surround',
    event = 'BufRead',
    config = function()
      require("nvim-surround").setup({})
    end
  })

  use({ 'wellle/targets.vim' })
  use({ 'tpope/vim-repeat', keys = '.' })
  use 'skamsie/vim-lineletters'

  -- PlantUML Syntax (TreeSitter is not supported as of 07-22)
  use({ 'aklt/plantuml-syntax' })

  use 'Oldenborg/vim-px-to-rem'

  use({
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
       sign = { enabled = false },
       heading = {
         position = 'inline',
         -- icons = { "#", "##", "###", "#x4", "#####", "######" },
         icons = { "h₁", "h₂ ", "h₃  ", "h₄   ", "h₅    ", "h₆     " },

      },
      code = {
        left_pad = 1,
        right_pad = 1,
        style = 'normal',
        width = 'block',
      },
      dash = {
        width = 50 
      }
    },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  })

  use({
    "folke/noice.nvim",
    config = function()
      require('plugins.noice');
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  })
end

init()

return plugin_list;

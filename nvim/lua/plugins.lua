local present, _ = pcall(require, 'packerInit')
local packer

if (not vim.g.vscode) then
  if present then
    packer = require('packer')
  else
    return false
  end

  local use = packer.use

  return packer.startup(function()
    use('lewis6991/impatient.nvim')
    use({ 'wbthomason/packer.nvim', event = 'VimEnter' })
    use('duane9/nvim-rg')

    -- UI
    use({
      'VonHeikemen/searchbox.nvim',
      requires = {
        { 'MunifTanjim/nui.nvim' },
      },
    })
    use({
      'nvim-lualine/lualine.nvim',
      config = function()
        require('plugins.lualine')
      end,
    })
    use({
      'luukvbaal/stabilize.nvim',
      config = function()
        require('stabilize').setup()
      end,
    })
    use({
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = function()
        require('plugins.indentline')
      end,
    })
    -- use({
    --   'monsonjeremy/onedark.nvim',
    --   after = 'lualine.nvim',
    --   config = function()
    --     require('plugins.onedark').setupOneDark()
    --   end,
    -- })
    use({
      'kyazdani42/nvim-web-devicons',
      event = 'BufRead',
      config = function()
        require('plugins.nvim-web-devicons')
      end,
    })

    -- LSP
    use({
      'glepnir/lspsaga.nvim', {branch = 'main' },
      event = 'BufRead',
      config = function()
        require("lspsaga").init_lsp_saga();
      end,
    })
    use({ 'ray-x/lsp_signature.nvim', event = 'BufRead' })
    use({ 'folke/lua-dev.nvim', event = 'BufRead' })
    use({ 'williamboman/nvim-lsp-installer', event = 'BufRead' })
    use({ 'nvim-lua/lsp_extensions.nvim', event = 'BufRead' })
    use({
      'ojroques/nvim-lspfuzzy',
      requires = {
        { 'junegunn/fzf', event = 'BufRead' },
        { 'junegunn/fzf.vim', event = 'BufRead' },
      },
      event = 'BufRead',
      config = function()
        require('lspfuzzy').setup({})
      end,
    })
    use({
      'filipdutescu/renamer.nvim',
      event = 'BufRead',
      after = 'plenary.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('renamer').setup()
      end,
    })
    use({
      'folke/trouble.nvim',
      event = 'BufRead',
      after = 'nvim-web-devicons',
      config = function()
        require('trouble').setup({})
      end,
    })
    use({
      'onsails/lspkind-nvim',
      event = 'BufRead',
      module = 'lspkind',
    })
    use({
      'neovim/nvim-lspconfig',
      config = function()
        require('lsp')
      end,
      after = {
        'cmp',
        'cmp-nvim-lsp',
        'nvim-lsp-installer',
        'lspsaga.nvim',
        'lsp_signature.nvim',
        'lua-dev.nvim',
        'lsp_extensions.nvim',
        'nvim-lspfuzzy',
        'trouble.nvim',
        'lspkind-nvim',
      },
    })

    use({
      'jose-elias-alvarez/null-ls.nvim',
      after = 'nvim-lspconfig',
      module = 'null-ls',
    })

    use({
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      after = 'nvim-lspconfig',
      module = 'nvim-lsp-ts-utils',
    })

    use({
      'simrat39/rust-tools.nvim',
      ft = 'rs',
      config = function()
        require('rust-tools').setup()
      end,
    })

    -- Terminal
    use({
      'akinsho/toggleterm.nvim',
      tag = 'v2.*',
      cmd = { 'TermExec', 'ToggleTerm' },
      config = function()
        require('plugins.toggleterm')
      end,
    })

    -- Navigation / Helpers
    use({ 'tpope/vim-fugitive', cmd = { 'Git' } })
    use({ 'nvim-lua/plenary.nvim' })
    use({ 'nvim-lua/popup.nvim', after = 'plenary.nvim' })
    use({
      'famiu/nvim-reload',
      cmd = 'Reload',
      config = function()
        local reload = require('nvim-reload')
        local plugin_dir = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
        reload.vim_reload_dirs = {}
        reload.lua_reload_dirs = {}
        reload.post_reload_hook = function()
          vim.cmd('source ' .. plugin_dir)
          vim.cmd('colorscheme nvcode')
        end
      end,
    })
    use({ 'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline' })
    use({'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('plugins.Comment')
      end,
      event = 'BufRead',
    })
    use({ 'AndrewRadev/dsf.vim', event = 'BufRead' })
    -- use({ 'chaoren/vim-wordmotion', event = 'BufRead' })
    use({ 'tweekmonster/startuptime.vim', cmd = 'StartupTime' })
    use({ 'tversteeg/registers.nvim', cmd = 'Registers' })
    use({
      'vuki656/package-info.nvim',
      requires = 'MunifTanjim/nui.nvim',
      ft = 'json',
      config = function()
        require('package-info').setup()
      end,
    })
    use({
      as = 'hop',
      config = function()
        require('plugins.hop')
      end,
    })

    use({ 'fedepujol/move.nvim', cmd = { 'MoveLine', 'MoveBlock' } })

    use({
      'goolord/alpha-nvim',
      config = function()
        require('plugins.dashboard')
      end,
    })

    use({
      'windwp/nvim-spectre',
      module = 'spectre',
      config = function()
        require('plugins.nvim-spectre')
      end,
    })

    use({
      'nvim-telescope/telescope.nvim',
      require = 'plenary.nvim',
      config = function()
        require('plugins.telescope')
      end,
    })
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use({
      'Shatur/neovim-session-manager',
      require = 'plenary.nvim',
      config = function()
        require('plugins.neovim-session-manager')
      end,
    })

    use({
      'nvim-treesitter/nvim-treesitter-refactor',
      event = 'BufRead',
      after = 'nvim-treesitter',
    })

    use({ 'nvim-treesitter/playground', cmd = 'TSPlayground' })

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('plugins.nvim-treesitter')
      end,
    }

    use({ 'p00f/nvim-ts-rainbow', event = 'BufRead', after = 'nvim-treesitter' })

    use({ 'windwp/nvim-ts-autotag', event = 'BufRead', after = 'nvim-treesitter' })

    use({
      'windwp/nvim-autopairs',
      after = 'cmp',
      event = 'BufRead',
      config = function()
        require('plugins.autopairs')
      end,
    })

    use({
      'L3MON4D3/LuaSnip',
      config = function()
        require("luasnip").config.setup({ store_selection_keys="<C-i>" })
      end
    })

    use({
      'hrsh7th/nvim-cmp',
      as = 'cmp',
      config = function()
        require('plugins.compe')
      end,
      wants = {
        'LuaSnip',
        'cmp_luasnip',
        'cmp-nvim-lsp',
        'cmp-buffer',
        'cmp-path',
        'cmp-treesitter',
        'cmp-spell',
        'cmp-rg',
      },
      requires = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        { 'hrsh7th/cmp-buffer', event = 'InsertCharPre' },
        { 'hrsh7th/cmp-path', event = 'InsertCharPre' },
        { 'f3fora/cmp-spell', event = 'InsertCharPre' },
        { 'ray-x/cmp-treesitter', event = 'InsertCharPre' },
        { 'lukas-reineke/cmp-rg', event = 'InsertCharPre' },
      },
    })

    use({ 'hrsh7th/cmp-nvim-lsp', event = 'BufRead', after = 'cmp' })

    use({
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons',
      event = 'BufRead',
      config = function()
        require('plugins.bufferline')
      end,
    })

    use({ 'ton/vim-bufsurf', event = 'BufRead' })

    use({
      'lewis6991/gitsigns.nvim',
      event = 'BufRead',
      after = 'plenary.nvim',
      config = function()
        require('plugins.gitsigns')
      end,
    })

    use({
      'kyazdani42/nvim-tree.lua',
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
      after = 'nvim-web-devicons',
      config = function()
        require('plugins.nvim-tree')
      end,
    })

    use({
      'norcalli/nvim-colorizer.lua',
      event = 'BufRead',
      config = function()
        require('colorizer').setup()
      end,
    })

    use({
      'folke/which-key.nvim',
      config = function()
        require('which-key').setup()
      end,
    })

    -- use({
    --   'dsznajder/vscode-es7-javascript-react-snippets',
    --   run = 'yarn install --frozen-lockfile && yarn compile',
    -- })

    use({
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      after = 'plenary.nvim',
      config = function()
        require('neogit').setup({})
      end,
    })

    use({ 'nathom/filetype.nvim' })

    use { 'ibhagwan/fzf-lua',
      requires = {
        'vijaymarupudi/nvim-fzf',
        'kyazdani42/nvim-web-devicons' } -- optional for icons
    }

    use {
      'theblob42/drex.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() 
        require('plugins.drex')
      end,
    }

    use 'famiu/bufdelete.nvim'

    -- use ({ 'styled-components/vim-styled-components', branch = 'main' })
    use ({ 'charliesbot/night-owl.vim' })
    use 'folke/tokyonight.nvim'
    use 'Mofiqul/vscode.nvim'

    use({
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup({
          easing_function = 'quintic' -- Default easing function
        })
      end,
    })

    -- Experimental 
    use 'ggandor/lightspeed.nvim'
    use({ "catppuccin/nvim", as = "catppuccin" })
    use({
      'TaDaa/vimade',
      cmd = 'BufRead',
      config = function()
        require('vimade').setup()
      end
    })

    -- Experimental - use of next-gen surrounding
    -- use({ 'tpope/vim-surround', event = 'BufRead'})
    use({ 'kylechui/nvim-surround', event = 'BufRead',
    config = function() 
       require("nvim-surround").setup({})
      end
  })
    use({ 'wellle/targets.vim' })
    use({ 'tpope/vim-repeat', keys = '.' })

    use {
      "folke/zen-mode.nvim",
      cmd = 'ZenMode',
      config = function()
        require("zen-mode").setup {}
      end
    }

    use({ 'andymass/vim-matchup', after = 'nvim-treesitter' })
    
    -- PlantUML Syntax (TreeSitter is not supported as of 07-22)
    use({'aklt/plantuml-syntax'})

    use({'christianchiarulli/nvcode-color-schemes.vim'})

    use({
      'danymat/neogen',
      module = 'neogen',
      cmd = 'Neogen',
      config = function()
        require('neogen').setup({ enabled = true })
      end,
    })
  end, {
    config = {
      -- Move to lua dir so impatient.nvim can cache it
      compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',
    },
  })
end

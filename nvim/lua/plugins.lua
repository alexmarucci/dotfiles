local present, _ = pcall(require, 'packerInit')
local packer

local not_vscode = function()
  return vim.g.vscode == nil;
end

if present then
  packer = require('packer')
else
  return false
end

local use = packer.use

return packer.startup(function()
  use({ 'lewis6991/impatient.nvim' })
  use({ 'wbthomason/packer.nvim', event = 'VimEnter' })
  use 'duane9/nvim-rg'

  -- -- UI
  use({
    'VonHeikemen/searchbox.nvim',
    cond = not_vscode,
    requires = {
      { 'MunifTanjim/nui.nvim' },
    },
  })
  use({
    'nvim-lualine/lualine.nvim',
    cond = not_vscode,
    config = function()
      require('plugins.lualine')
    end,
  })
  use({
    'luukvbaal/stabilize.nvim',
    cond = not_vscode,
    config = function()
      require('stabilize').setup()
    end,
  })

  -- -- Does not actually indent... adds vertical lines on indentation
  use({
    'lukas-reineke/indent-blankline.nvim',
    cond = not_vscode,
    event = 'BufRead',
    config = function()
      require('plugins.indentline')
    end,
  })

  use({
    'kyazdani42/nvim-web-devicons',
    --[[ cond = {vscode}, ]]
    event = 'BufRead',
    config = function()
      require('plugins.nvim-web-devicons')
    end,
  })

  -- LSP
  use({
    'glepnir/lspsaga.nvim',
    branch = 'main',
    cond = not_vscode,
    event = 'BufRead',
    config = function()
      require("lspsaga").init_lsp_saga();
    end,
  })
  use({ 'ray-x/lsp_signature.nvim', cond = not_vscode, event = 'BufRead' })
  use({ 'folke/neodev.nvim', event = 'BufRead' })
  use({ 'williamboman/nvim-lsp-installer', event = 'BufRead' })
  use({ 'nvim-lua/lsp_extensions.nvim', cond = not_vscode, event = 'BufRead' })
  -- we use telescope instead
  -- use({
  --   'ojroques/nvim-lspfuzzy',
  --   cond = not_vscode,
  --   requires = {
  --     { 'junegunn/fzf', event = 'BufRead' },
  --     { 'junegunn/fzf.vim', event = 'BufRead' },
  --   },
  --   event = 'BufRead',
  --   config = function()
  --     require('lspfuzzy').setup({})
  --   end,
  -- })
  use({
    'filipdutescu/renamer.nvim',
    cond = not_vscode,
    event = 'BufRead',
    after = 'plenary.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('renamer').setup({})
    end,
  })
  use({
    'folke/trouble.nvim',
    cond = not_vscode,
    event = 'BufRead',
    after = 'nvim-web-devicons',
    config = function()
      require('trouble').setup({})
    end,
  })
  use({
    'onsails/lspkind-nvim',
    cond = not_vscode,
    event = 'BufRead',
    module = 'lspkind',
  })
  use({
    'neovim/nvim-lspconfig',
    cond = not_vscode,
    config = function()
      require('lsp.init')
    end,
    after = {
      'cmp',
      'cmp-nvim-lsp',
      'nvim-lsp-installer',
      'lspsaga.nvim',
      'lsp_signature.nvim',
      'neodev.nvim',
      'lsp_extensions.nvim',
      -- marked for deletion
      -- 'nvim-lspfuzzy',
      'trouble.nvim',
      'lspkind-nvim',
    },
  })

  use({
    cond = not_vscode,
    'jose-elias-alvarez/null-ls.nvim',
    after = 'nvim-lspconfig',
    module = 'null-ls',
  })

  use({
    cond = not_vscode,
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    after = 'nvim-lspconfig',
    module = 'nvim-lsp-ts-utils',
  })

  -- use({
  --   cond = not_vscode,
  --   'simrat39/rust-tools.nvim',
  --   ft = 'rs',
  --   config = function()
  --     require('rust-tools').setup()
  --   end,
  -- })

  -- -- Terminal
  use({
    cond = not_vscode,
    'akinsho/toggleterm.nvim',
    tag = 'v2.*',
    cmd = { 'TermExec', 'ToggleTerm' },
    config = function()
      require('plugins.toggleterm')
    end,
  })

  -- Navigation / Helpers
  --[[ use({ 'tpope/vim-fugitive', cond = {vscode}, cmd = { 'Git' } }) ]]
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'nvim-lua/popup.nvim', cond = not_vscode, after = 'plenary.nvim' })
  use({
    'famiu/nvim-reload',
    cmd = 'Reload',
    cond = not_vscode,
    config = function()
      local reload = require('nvim-reload')
      local plugin_dir = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
      reload.vim_reload_dirs = {}
      reload.lua_reload_dirs = {}
      reload.post_reload_hook = function()
        vim.cmd('source ' .. plugin_dir)
        vim.cmd('colorscheme vscode')
      end
    end,
  })
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
  -- use({ 'chaoren/vim-wordmotion', event = 'BufRead' })
  use({ 'tweekmonster/startuptime.vim', cond = not_vscode, cmd = 'StartupTime' })
  use({ 'tversteeg/registers.nvim', cond = not_vscode, cmd = 'Registers' })
  use({
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    ft = 'json',
    config = function()
      require('package-info').setup()
    end,
  })

  -- use({ 'fedepujol/move.nvim', cmd = { 'MoveLine', 'MoveBlock' } })

  use({
    'goolord/alpha-nvim',
    cond = not_vscode,
    config = function()
      require('plugins.dashboard')
    end,
  })

  use({
    'nvim-pack/nvim-spectre',
    cond = not_vscode,
    require = 'plenary.nvim',
    module = 'spectre',
    config = function()
      require('plugins.nvim-spectre')
    end,
  })

  use({
    'nvim-telescope/telescope.nvim',
    require = 'plenary.nvim',
    cond = not_vscode,
    config = function()
      require('plugins.telescope')
    end,
  })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = not_vscode,
    run = 'make'
  })

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
    'JoosepAlviste/nvim-ts-context-commentstring',
    cond = not_vscode,
    after = 'nvim-treesitter'
  })

  use({
    'nvim-treesitter/nvim-treesitter-context',
    cond = not_vscode,
    event = 'BufRead',
    after = 'nvim-treesitter',
    config = function()
      require('plugins.nvim-treesitter-context')
    end,
  })

  use({ 'nvim-treesitter/playground', cmd = 'TSPlayground' })

  use {
    'nvim-treesitter/nvim-treesitter',
    cond = not_vscode,
    run = ':TSUpdate',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  }

   use({
     'p00f/nvim-ts-rainbow',
     cond = not_vscode,
     event = 'BufRead',
     after = 'nvim-treesitter'
   })

  use({
    'windwp/nvim-ts-autotag',
    cond = not_vscode,
    event = 'BufRead',
    after = 'nvim-treesitter'
  })

  use({
    'L3MON4D3/LuaSnip',
    cond = not_vscode,
    config = function()
      require("luasnip").setup({ store_selection_keys="<C-i>" })
    end
  })

  use({
    'pwntester/octo.nvim',
    cmd = "Octo",
    config = function ()
      require"octo".setup()
    end
  })

  use({
    'hrsh7th/nvim-cmp',
    as = 'cmp',
    cond = not_vscode,
    opt = false,
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

  use({ 'hrsh7th/cmp-nvim-lsp', cond = not_vscode, event = 'BufRead', after = 'cmp' })
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
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    event = 'BufRead',
    cond = not_vscode,
    config = function()
      require('plugins.bufferline')
    end,
  })

  use({ 'ton/vim-bufsurf', cond = not_vscode, event = 'BufRead' })

  use({
    cond = not_vscode,
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    after = 'plenary.nvim',
    config = function()
      require('plugins.gitsigns')
    end,
  })

  -- marked to be removed
  -- use({
  --   'kyazdani42/nvim-tree.lua',
  --   cond = not_vscode,
  --   cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
  --   after = 'nvim-web-devicons',
  --   config = function()
  --     require('plugins.nvim-tree')
  --   end,
  -- })

  -- adds background color to hex text #fff
  use({
    'norcalli/nvim-colorizer.lua',
    cond = not_vscode,
    event = 'BufRead',
    config = function()
      require('colorizer').setup()
    end,
  })

  use({
    'folke/which-key.nvim',
    cond = not_vscode,
    config = function()
      require('which-key').setup()
    end,
  })

  -- -- use({
  -- --   'dsznajder/vscode-es7-javascript-react-snippets',
  -- --   run = 'yarn install --frozen-lockfile && yarn compile',
  -- -- })

  -- use({
  --   cond = not_vscode,
  --   'TimUntersberger/neogit',
  --   cmd = 'Neogit',
  --   after = 'plenary.nvim',
  --   config = function()
  --     require('neogit').setup({})
  --   end,
  -- })

  use({ 'nathom/filetype.nvim' })

  -- use { 'ibhagwan/fzf-lua',
  --   requires = {
  --     'vijaymarupudi/nvim-fzf',
  --     'kyazdani42/nvim-web-devicons' } -- optional for icons
  -- }

  use {
    'theblob42/drex.nvim',
    cond = not_vscode,
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.drex')
    end,
  }

  use 'famiu/bufdelete.nvim'

  -- Themes colorscheme
  --[[ use ({ 'styled-components/vim-styled-components', branch = 'main' }) ]]
  use ({ 'charliesbot/night-owl.vim' })
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/vscode.nvim'

  use({
    'karb94/neoscroll.nvim',
    cond = not_vscode,
    config = function()
      require('neoscroll').setup({
        easing_function = 'quintic' -- Default easing function
      })
    end,
  })

  -- -- Experimental
  use 'takac/vim-hardtime'
  --[[ use 'ggandor/lightspeed.nvim' ]]
  -- use({ "catppuccin/nvim", as = "catppuccin" })
  -- --fades inactive buffers
  --[[ use({ ]]
  --[[   'TaDaa/vimade', ]]
  --[[   event = 'BufRead', ]]
  --[[   cond = not_vscode, ]]
  --[[   config = function() ]]
  --[[     require('vimade').setup() ]]
  --[[   end ]]
  --[[ }) ]]

  -- Experimental - use of next-gen surrounding
  -- use({ 'tpope/vim-surround', event = 'BufRead'})
  use({
    'kylechui/nvim-surround',
    event = 'BufRead',
    config = function()
     require("nvim-surround").setup({})
    end
  })

  use({ 'wellle/targets.vim' })
  use({ 'tpope/vim-repeat', keys = '.' })

  -- use {
  --   "folke/zen-mode.nvim",
  --   cmd = 'ZenMode',
  --   config = function()
  --     require("zen-mode").setup {}
  --   end
  -- }

  -- use({ 'andymass/vim-matchup', cond = not_vscode, after = 'nvim-treesitter' })

  use 'rhysd/clever-f.vim'

  use({
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings();
    end,
  })

  -- PlantUML Syntax (TreeSitter is not supported as of 07-22)
  use({'aklt/plantuml-syntax'})

  use({
    cond = not_vscode,
    'mfussenegger/nvim-dap',
  })

  use {
    'rcarriga/nvim-dap-ui',
    cond = not_vscode,
    requires = { 'mfussenegger/nvim-dap' },
    event = 'BufRead',
    config = function ()
      require("plugins.nvim-dap-ui")
    end
  }

  use {
    "microsoft/vscode-js-debug",
    cond = not_vscode,
    opt = true,
    run = "npm install --legacy-peer-deps && npm run compile"
  }

  use {
    "mxsdev/nvim-dap-vscode-js",
    cond = not_vscode,
    requires = {"mfussenegger/nvim-dap"},
    config = function ()
      require('plugins.nvim-dap-vscode-js');
    end
  }

  use({ 'rose-pine/neovim', as = 'rose-pine' })

  -- use({
  --   'danymat/neogen',
  --   cond = not_vscode,
  --   module = 'neogen',
  --   cmd = 'Neogen',
  --   config = function()
  --     require('neogen').setup({ enabled = true })
  --   end,
  -- })

end, {
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua',
  },
})

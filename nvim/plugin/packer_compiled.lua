-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/alessio/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/alessio/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/alessio/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/alessio/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/alessio/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  Cd = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/Cd",
    url = "https://github.com/nanotee/zoxide.vim"
  },
  ["Comment.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.Comment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\25store_selection_keys\n<C-i>\nsetup\fluasnip\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.dashboard\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  cmp = {
    after = { "nvim-lspconfig", "nvim-autopairs", "cmp-spell", "cmp-treesitter", "cmp_luasnip", "cmp-rg", "cmp-path", "cmp-tabnine", "cmp-buffer", "cmp-nvim-lsp" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18plugins.compe\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after = { "nvim-lspconfig" },
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-rg/after/plugin/cmp-rg.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-spell"] = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-spell/after/plugin/cmp-spell.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-tabnine"] = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-tabnine/after/plugin/cmp-tabnine.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  ["cmp-treesitter"] = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-treesitter/after/plugin/cmp_treesitter.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    after_files = { "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["dracula.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/dracula.nvim",
    url = "https://github.com/Mofiqul/dracula.nvim"
  },
  ["drex.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17plugins.drex\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/drex.nvim",
    url = "https://github.com/theblob42/drex.nvim"
  },
  ["dsf.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/dsf.vim",
    url = "https://github.com/AndrewRadev/dsf.vim"
  },
  ["easypick.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.easypick\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/easypick.nvim",
    url = "https://github.com/axkirillov/easypick.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["flash.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18plugins.flash\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/flash.nvim",
    url = "https://github.com/folke/flash.nvim"
  },
  ["gitsigns.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.gitsigns\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com//home/alessio/projects/hacks/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.indentline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.kanagawa\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lsp_extensions.nvim"] = {
    after = { "nvim-lspconfig" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    after = { "nvim-lspconfig" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    after = { "nvim-lspconfig" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    after = { "nvim-lspconfig" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n±\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21symbol_in_winbar\1\0\0\1\0\a\14separator\tï‘Š \venable\1\15color_mode\2\17hide_keyword\2\14show_file\2\17folder_level\3\2\17respect_root\1\nsetup\flspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20plugins.lualine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    after = { "nvim-lspconfig" },
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20mason-lspconfig\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    after = { "nvim-lspconfig", "mason-lspconfig.nvim" },
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["monokai.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/monokai.nvim",
    url = "https://github.com/tanvirtin/monokai.nvim"
  },
  ["neodev.nvim"] = {
    after = { "nvim-lspconfig" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["neoscroll.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\20easing_function\fquintic\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["neovim-session-manager"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n>\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0#plugins.neovim-session-manager\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/neovim-session-manager",
    url = "https://github.com/Shatur/neovim-session-manager"
  },
  nightfly = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/nightfly",
    url = "https://github.com/bluz71/vim-nightfly-colors"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18plugins.noice\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/nord.nvim",
    url = "https://github.com/gbprod/nord.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  nvim = {
    config = { "\27LJ\2\næ\1\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\vstyles\rkeywords\1\2\0\0\vitalic\17conditionals\1\2\0\0\vitalic\rcomments\1\0\0\1\2\0\0\vitalic\15background\1\0\2\nlight\nlatte\tdark\vfrappe\1\0\1\fflavour\vfrappe\nsetup\15catppuccin\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-autopairs"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.autopairs\frequire\0" },
    load_after = {
      cmp = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24plugins.nvim-dap-ui\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-vscode-js"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.nvim-dap-vscode-js\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-dap-vscode-js",
    url = "https://github.com/mxsdev/nvim-dap-vscode-js"
  },
  ["nvim-lspconfig"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rlsp.init\frequire\0" },
    load_after = {
      cmp = true,
      ["cmp-nvim-lsp"] = true,
      ["lsp_extensions.nvim"] = true,
      ["lsp_signature.nvim"] = true,
      ["lspkind-nvim"] = true,
      ["lspsaga.nvim"] = true,
      ["mason-lspconfig.nvim"] = true,
      ["neodev.nvim"] = true,
      ["trouble.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\nf\0\0\3\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\1\0B\0\2\1K\0\1\0\19load_extension\14telescope\nsetup\fneoclip\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-rg"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/nvim-rg",
    url = "https://github.com/duane9/nvim-rg"
  },
  ["nvim-spectre"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins.nvim-spectre\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-spectre",
    url = "https://github.com/nvim-pack/nvim-spectre"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-rainbow", "nvim-ts-autotag", "nvim-treesitter-refactor", "nvim-treesitter-textobjects", "nvim-ts-context-commentstring", "nvim-treesitter-context" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.nvim-treesitter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$plugins.nvim-treesitter-context\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-refactor"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/mrjones2014/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    after = { "trouble.nvim" },
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.nvim-web-devicons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    commands = { "Octo" },
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tocto\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["oil.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\boil\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["one_monokai.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/one_monokai.nvim",
    url = "https://github.com/cpea2506/one_monokai.nvim"
  },
  ["onedarkpro.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.onedarkpro\frequire\0" },
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/onedarkpro.nvim",
    url = "https://github.com/olimorris/onedarkpro.nvim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plantuml-syntax"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/plantuml-syntax",
    url = "https://github.com/aklt/plantuml-syntax"
  },
  playground = {
    commands = { "TSPlayground" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["registers.nvim"] = {
    commands = { "Registers" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim"
  },
  ["renamer.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\frenamer\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim"
  },
  ["rose-pine"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["smart-open.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\15smart_open\19load_extension\14telescope\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/smart-open.nvim",
    url = "https://github.com/danielfalk/smart-open.nvim"
  },
  ["solarized.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/solarized.nvim",
    url = "https://github.com/shaunsingh/solarized.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  ["stabilize.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/startuptime.vim",
    url = "https://github.com/tweekmonster/startuptime.vim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-search-dir-picker.nvim"] = {
    config = { "\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\22search_dir_picker\19load_extension\14telescope\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/telescope-search-dir-picker.nvim",
    url = "https://github.com/smilovanovic/telescope-search-dir-picker.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-search-dir-picker.nvim", "nvim-neoclip.lua", "telescope-fzf-native.nvim" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22plugins.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  thematrix = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/thematrix",
    url = "https://github.com/luisiacc/the-matrix.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "TermExec", "ToggleTerm" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.toggleterm\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    after = { "nvim-lspconfig" },
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    load_after = {
      ["nvim-web-devicons"] = true
    },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["typescript.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  undotree = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-bufsurf"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/vim-bufsurf",
    url = "https://github.com/ton/vim-bufsurf"
  },
  ["vim-deus"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/vim-deus",
    url = "https://github.com/ajmwagar/vim-deus"
  },
  ["vim-github"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/vim-github",
    url = "https://github.com/cschlueter/vim-github"
  },
  ["vim-hardtime"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/vim-hardtime",
    url = "https://github.com/takac/vim-hardtime"
  },
  ["vim-lineletters"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/vim-lineletters",
    url = "https://github.com/skamsie/vim-lineletters"
  },
  ["vim-px-to-rem"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/vim-px-to-rem",
    url = "https://github.com/Oldenborg/vim-px-to-rem"
  },
  ["vim-repeat"] = {
    keys = { { "", "." } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vscode-js-debug"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/vscode-js-debug",
    url = "https://github.com/microsoft/vscode-js-debug"
  },
  ["vscode.nvim"] = {
    loaded = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/start/vscode.nvim",
    url = "https://github.com/Mofiqul/vscode.nvim"
  },
  ["which-key.nvim"] = {
    cond = { "\27LJ\2\n8\0\0\1\0\3\0\t6\0\0\0009\0\1\0009\0\2\0\n\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\vvscode\6g\bvim\0" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/alessio/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^lspkind"] = "lspkind-nvim",
  ["^spectre"] = "nvim-spectre"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: kanagawa.nvim
time([[Config for kanagawa.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.kanagawa\frequire\0", "config", "kanagawa.nvim")
time([[Config for kanagawa.nvim]], false)
-- Config for: nvim
time([[Config for nvim]], true)
try_loadstring("\27LJ\2\næ\1\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\a\0005\4\6\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\vstyles\rkeywords\1\2\0\0\vitalic\17conditionals\1\2\0\0\vitalic\rcomments\1\0\0\1\2\0\0\vitalic\15background\1\0\2\nlight\nlatte\tdark\vfrappe\1\0\1\fflavour\vfrappe\nsetup\15catppuccin\frequire\0", "config", "nvim")
time([[Config for nvim]], false)
-- Config for: noice.nvim
time([[Config for noice.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18plugins.noice\frequire\0", "config", "noice.nvim")
time([[Config for noice.nvim]], false)
-- Config for: easypick.nvim
time([[Config for easypick.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins.easypick\frequire\0", "config", "easypick.nvim")
time([[Config for easypick.nvim]], false)
-- Config for: flash.nvim
time([[Config for flash.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18plugins.flash\frequire\0", "config", "flash.nvim")
time([[Config for flash.nvim]], false)
-- Config for: onedarkpro.nvim
time([[Config for onedarkpro.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.onedarkpro\frequire\0", "config", "onedarkpro.nvim")
time([[Config for onedarkpro.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: oil.nvim
time([[Config for oil.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\boil\frequire\0", "config", "oil.nvim")
time([[Config for oil.nvim]], false)
-- Conditional loads
time([[Conditional loading of nvim-dap-vscode-js]], true)
  require("packer.load")({"nvim-dap-vscode-js"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-dap-vscode-js]], false)
time([[Conditional loading of telescope.nvim]], true)
  require("packer.load")({"telescope.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of telescope.nvim]], false)
time([[Conditional loading of popup.nvim]], true)
  require("packer.load")({"popup.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of popup.nvim]], false)
time([[Conditional loading of which-key.nvim]], true)
  require("packer.load")({"which-key.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of which-key.nvim]], false)
time([[Conditional loading of nvim-dap]], true)
  require("packer.load")({"nvim-dap"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-dap]], false)
time([[Conditional loading of nvim-treesitter]], true)
  require("packer.load")({"nvim-treesitter"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-treesitter]], false)
time([[Conditional loading of LuaSnip]], true)
  require("packer.load")({"LuaSnip"}, {}, _G.packer_plugins)
time([[Conditional loading of LuaSnip]], false)
time([[Conditional loading of cmp]], true)
  require("packer.load")({"cmp"}, {}, _G.packer_plugins)
time([[Conditional loading of cmp]], false)
time([[Conditional loading of nvim-ts-autotag]], true)
  require("packer.load")({"nvim-ts-autotag"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-ts-autotag]], false)
time([[Conditional loading of null-ls.nvim]], true)
  require("packer.load")({"null-ls.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of null-ls.nvim]], false)
time([[Conditional loading of drex.nvim]], true)
  require("packer.load")({"drex.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of drex.nvim]], false)
time([[Conditional loading of nvim-treesitter-textobjects]], true)
  require("packer.load")({"nvim-treesitter-textobjects"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-treesitter-textobjects]], false)
time([[Conditional loading of nvim-ts-context-commentstring]], true)
  require("packer.load")({"nvim-ts-context-commentstring"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-ts-context-commentstring]], false)
time([[Conditional loading of cmp-tabnine]], true)
  require("packer.load")({"cmp-tabnine"}, {}, _G.packer_plugins)
time([[Conditional loading of cmp-tabnine]], false)
time([[Conditional loading of stabilize.nvim]], true)
  require("packer.load")({"stabilize.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of stabilize.nvim]], false)
time([[Conditional loading of neoscroll.nvim]], true)
  require("packer.load")({"neoscroll.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of neoscroll.nvim]], false)
time([[Conditional loading of alpha-nvim]], true)
  require("packer.load")({"alpha-nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of alpha-nvim]], false)
time([[Conditional loading of lualine.nvim]], true)
  require("packer.load")({"lualine.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of lualine.nvim]], false)
time([[Conditional loading of telescope-fzf-native.nvim]], true)
  require("packer.load")({"telescope-fzf-native.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of telescope-fzf-native.nvim]], false)
time([[Conditional loading of vscode-js-debug]], true)
  require("packer.load")({"vscode-js-debug"}, {}, _G.packer_plugins)
time([[Conditional loading of vscode-js-debug]], false)
time([[Conditional loading of neovim-session-manager]], true)
  require("packer.load")({"neovim-session-manager"}, {}, _G.packer_plugins)
time([[Conditional loading of neovim-session-manager]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd sqlite.lua ]]
vim.cmd [[ packadd telescope-frecency.nvim ]]

-- Config for: telescope-frecency.nvim
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")

vim.cmd [[ packadd smart-open.nvim ]]

-- Config for: smart-open.nvim
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\15smart_open\19load_extension\14telescope\frequire\0", "config", "smart-open.nvim")

vim.cmd [[ packadd plenary.nvim ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'ToggleTerm', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'ToggleTerm', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ToggleTerm ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TermExec', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'TermExec', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TermExec ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'StartupTime', function(cmdargs)
          require('packer.load')({'startuptime.vim'}, { cmd = 'StartupTime', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'startuptime.vim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('StartupTime ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'SymbolsOutline', function(cmdargs)
          require('packer.load')({'symbols-outline.nvim'}, { cmd = 'SymbolsOutline', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'symbols-outline.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('SymbolsOutline ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Registers', function(cmdargs)
          require('packer.load')({'registers.nvim'}, { cmd = 'Registers', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'registers.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Registers ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Octo', function(cmdargs)
          require('packer.load')({'octo.nvim'}, { cmd = 'Octo', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'octo.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Octo ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSPlayground', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSPlayground', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSPlayground ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> . <cmd>lua require("packer.load")({'vim-repeat'}, { keys = ".", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-bufsurf', 'typescript.nvim', 'nvim-web-devicons', 'nvim-lspconfig', 'gitsigns.nvim', 'nvim-autopairs', 'conflict-marker.vim', 'renamer.nvim', 'nvim-colorizer.lua', 'nvim-ts-rainbow', 'trouble.nvim', 'nvim-treesitter-refactor', 'indent-blankline.nvim', 'nvim-surround', 'dsf.vim', 'lsp_signature.nvim', 'bufferline.nvim', 'lsp_extensions.nvim', 'mason-lspconfig.nvim', 'cmp-nvim-lsp', 'neodev.nvim', 'lspsaga.nvim', 'Comment.nvim', 'nvim-treesitter-context', 'nvim-dap-ui', 'lspkind-nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'cmp-spell', 'cmp-treesitter', 'cmp_luasnip', 'cmp-rg', 'cmp-path', 'cmp-buffer'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'packer.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

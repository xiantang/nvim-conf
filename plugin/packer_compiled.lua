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
local package_path_str = "/Users/jingdizhu/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/jingdizhu/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/jingdizhu/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/jingdizhu/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/jingdizhu/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
  ["Comment.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["Navigator.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14Navigator\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/Navigator.nvim",
    url = "https://github.com/numToStr/Navigator.nvim"
  },
  ReplaceWithRegister = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/ReplaceWithRegister",
    url = "https://github.com/vim-scripts/ReplaceWithRegister"
  },
  ["argtextobj.vim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/argtextobj.vim",
    url = "https://github.com/vim-scripts/argtextobj.vim"
  },
  ["clever-f.vim"] = {
    config = { "\27LJ\2\n‚\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\24clever_f_smart_case\25clever_f_ignore_case\28clever_f_across_no_line\6g\bvim\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/clever-f.vim",
    url = "https://github.com/rhysd/clever-f.vim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-dictionary"] = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-dictionary/after/plugin/cmp_dictionary.vim" },
    config = { "\27LJ\2\nî\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\bdic\1\0\a\rcapacity\3\5\ndebug\1\14max_items\3ÿÿÿÿ\15\nasync\2\27first_case_insensitive\1\rdocument\1\nexact\3ÿÿÿÿ\15\6*\1\0\0\1\3\0\0\25~/.config/nvim/words&~/.config/nvim/spell/en.utf-8.add\nsetup\19cmp_dictionary\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-dictionary",
    url = "https://github.com/uga-rosa/cmp-dictionary"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["copilot.lua"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcopilot\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["extract-value.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21extract_variable\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/extract-value.nvim",
    url = "/Users/jingdizhu/project/extract-value.nvim"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  firenvim = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/firenvim",
    url = "https://github.com/glacambre/firenvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fugitive-gitlab.vim"] = {
    config = { "\27LJ\2\n£\1\0\0\5\0\t\1\0226\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0\15\0\0\0X\1\t€6\1\4\0'\3\5\0B\1\2\0026\2\0\0009\2\6\0024\3\3\0009\4\b\1>\4\1\3=\3\a\2K\0\1\0\15GITALB_URL\28fugitive_gitlab_domains\6g\vsecret\frequire\bmac\bhas\afn\bvim\2\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/fugitive-gitlab.vim",
    url = "https://github.com/shumphrey/fugitive-gitlab.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["go.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\24dfgjkalwertyuizxcnm\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["im-select.nvim"] = {
    config = { "\27LJ\2\n¿\1\0\0\4\0\b\1\0196\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0\15\0\0\0X\1\6€6\1\4\0'\3\5\0B\1\2\0029\1\6\0015\3\a\0B\1\2\1K\0\1\0\1\0\2\25disable_auto_restore\3\0\22default_im_select\28com.apple.keylayout.ABC\nsetup\14im_select\frequire\bmac\bhas\afn\bvim\2\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/im-select.nvim",
    url = "https://github.com/keaising/im-select.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leetcode.vim"] = {
    config = { "\27LJ\2\nk\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\vgolang\31leetcode_solution_filetype\vchrome\21leetcode_browser\6g\bvim\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/leetcode.vim",
    url = "https://github.com/ianding1/leetcode.vim"
  },
  ["lsp-inlayhints.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19lsp-inlayhints\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/lsp-inlayhints.nvim",
    url = "https://github.com/lvimuser/lsp-inlayhints.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  nerdtree = {
    commands = { "NERDTreeToggle", "NERDTree", "NERDTreeFind" },
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["nerdtree-git-plugin"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nerdtree-git-plugin",
    url = "https://github.com/Xuyuanp/nerdtree-git-plugin"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-base16",
    url = "https://github.com/RRethy/nvim-base16"
  },
  ["nvim-cmp"] = {
    after = { "obsidian.nvim" },
    commands = { "ObsidianToday" },
    config = { "\27LJ\2\n\5\0\0\a\0\26\0=6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\0016\0\0\0009\0\1\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0'\2\5\0B\0\2\0016\0\0\0009\0\1\0'\2\6\0B\0\2\0016\0\a\0'\2\b\0B\0\2\0029\0\t\0005\2\v\0005\3\n\0=\3\f\2B\0\2\0016\0\a\0'\2\b\0B\0\2\0029\0\r\0005\2\15\0005\3\14\0=\3\16\2B\0\2\0016\0\a\0'\2\17\0B\0\2\0029\0\t\0005\2\18\0B\0\2\0016\0\a\0'\2\19\0B\0\2\0026\1\a\0'\3\20\0B\1\2\0029\1\21\1'\3\22\0009\4\23\0004\6\0\0B\4\2\0A\1\1\0016\1\a\0'\3\24\0B\1\2\0016\1\a\0'\3\25\0B\1\2\1K\0\1\0\fgo_test\fcmp_set\bnew\rcmp_jira\20register_source\bcmp\tjira\1\0\1\npaths$~/.config/nvim/my_snippets/lua/\29luasnip.loaders.from_lua\npaths\1\0\0\1\2\0\0./Users/jingdizhu/.config/nvim/my_snippets\14lazy_load\finclude\1\0\0\1\a\0\0\ago\vpython\ash\tjson\blua\14gitcommit\tload luasnip.loaders.from_vscode\frequire  PackerLoad cmp-dictionary \29 PackerLoad cmp_luasnip \25PackerLoad cmp-path \29 PackerLoad cmp-cmdline \28 PackerLoad cmp-buffer \bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-go"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-dap-go",
    url = "https://github.com/leoluz/nvim-dap-go"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/xiantang/nvim-lspconfig"
  },
  ["nvim-scrollbar"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["obsidian.nvim"] = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/obsidian.nvim/after/plugin/cmp_obsidian.lua", "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/obsidian.nvim/after/plugin/cmp_obsidian_new.lua" },
    config = { "\27LJ\2\n…\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15completion\1\0\1\rnvim_cmp\2\1\0\1\bdir(/Users/jingdizhu/Documents/my-vault\nsetup\robsidian\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/obsidian.nvim",
    url = "/Users/jingdizhu/project/obsidian.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["persistence.nvim"] = {
    config = { "\27LJ\2\nÈ\1\0\0\b\0\r\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0006\3\3\0009\3\4\0039\3\5\0036\5\3\0009\5\4\0059\5\6\5'\a\a\0B\5\2\2'\6\b\0&\5\6\5B\3\2\2=\3\n\0025\3\v\0=\3\f\2B\0\2\1K\0\1\0\foptions\1\4\0\0\vcurdir\rtabpages\fwinsize\bdir\1\0\0\15/sessions/\vconfig\fstdpath\vexpand\afn\bvim\nsetup\16persistence\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/persistence.nvim",
    url = "https://github.com/folke/persistence.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["profile.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/profile.nvim",
    url = "https://github.com/stevearc/profile.nvim"
  },
  sniprun = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/sniprun",
    url = "https://github.com/michaelb/sniprun"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-silicon"] = {
    config = { "\27LJ\2\nµ\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0•\1       let g:silicon={}\n       let g:plug_window = 'botright 40vnew'\n\t\t\t let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png'\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-silicon",
    url = "https://github.com/segeljakt/vim-silicon"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^persistence"] = "persistence.nvim"
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

-- Config for: Navigator.nvim
time([[Config for Navigator.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14Navigator\frequire\0", "config", "Navigator.nvim")
time([[Config for Navigator.nvim]], false)
-- Config for: leetcode.vim
time([[Config for leetcode.vim]], true)
try_loadstring("\27LJ\2\nk\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\vgolang\31leetcode_solution_filetype\vchrome\21leetcode_browser\6g\bvim\0", "config", "leetcode.vim")
time([[Config for leetcode.vim]], false)
-- Config for: fugitive-gitlab.vim
time([[Config for fugitive-gitlab.vim]], true)
try_loadstring("\27LJ\2\n£\1\0\0\5\0\t\1\0226\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0\15\0\0\0X\1\t€6\1\4\0'\3\5\0B\1\2\0026\2\0\0009\2\6\0024\3\3\0009\4\b\1>\4\1\3=\3\a\2K\0\1\0\15GITALB_URL\28fugitive_gitlab_domains\6g\vsecret\frequire\bmac\bhas\afn\bvim\2\0", "config", "fugitive-gitlab.vim")
time([[Config for fugitive-gitlab.vim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: im-select.nvim
time([[Config for im-select.nvim]], true)
try_loadstring("\27LJ\2\n¿\1\0\0\4\0\b\1\0196\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0\15\0\0\0X\1\6€6\1\4\0'\3\5\0B\1\2\0029\1\6\0015\3\a\0B\1\2\1K\0\1\0\1\0\2\25disable_auto_restore\3\0\22default_im_select\28com.apple.keylayout.ABC\nsetup\14im_select\frequire\bmac\bhas\afn\bvim\2\0", "config", "im-select.nvim")
time([[Config for im-select.nvim]], false)
-- Config for: extract-value.nvim
time([[Config for extract-value.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\21extract_variable\frequire\0", "config", "extract-value.nvim")
time([[Config for extract-value.nvim]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\24dfgjkalwertyuizxcnm\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: vim-silicon
time([[Config for vim-silicon]], true)
try_loadstring("\27LJ\2\nµ\1\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0•\1       let g:silicon={}\n       let g:plug_window = 'botright 40vnew'\n\t\t\t let g:silicon['output'] = '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png'\bcmd\bvim\0", "config", "vim-silicon")
time([[Config for vim-silicon]], false)
-- Config for: copilot.lua
time([[Config for copilot.lua]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fcopilot\frequire\0", "config", "copilot.lua")
time([[Config for copilot.lua]], false)
-- Config for: lsp-inlayhints.nvim
time([[Config for lsp-inlayhints.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\19lsp-inlayhints\frequire\0", "config", "lsp-inlayhints.nvim")
time([[Config for lsp-inlayhints.nvim]], false)
-- Config for: clever-f.vim
time([[Config for clever-f.vim]], true)
try_loadstring("\27LJ\2\n‚\1\0\0\2\0\5\0\r6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\24clever_f_smart_case\25clever_f_ignore_case\28clever_f_across_no_line\6g\bvim\0", "config", "clever-f.vim")
time([[Config for clever-f.vim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'NERDTree', function(cmdargs)
          require('packer.load')({'nerdtree'}, { cmd = 'NERDTree', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nerdtree'}, { cmd = 'NERDTree' }, _G.packer_plugins)
          return vim.fn.getcompletion('NERDTree ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NERDTreeFind', function(cmdargs)
          require('packer.load')({'nerdtree'}, { cmd = 'NERDTreeFind', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nerdtree'}, { cmd = 'NERDTreeFind' }, _G.packer_plugins)
          return vim.fn.getcompletion('NERDTreeFind ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ObsidianToday', function(cmdargs)
          require('packer.load')({'nvim-cmp'}, { cmd = 'ObsidianToday', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-cmp'}, { cmd = 'ObsidianToday' }, _G.packer_plugins)
          return vim.fn.getcompletion('ObsidianToday ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NERDTreeToggle', function(cmdargs)
          require('packer.load')({'nerdtree'}, { cmd = 'NERDTreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nerdtree'}, { cmd = 'NERDTreeToggle' }, _G.packer_plugins)
          return vim.fn.getcompletion('NERDTreeToggle ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
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

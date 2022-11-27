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
  ["cmp-dictionary"] = {
    after_files = { "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-dictionary/after/plugin/cmp_dictionary.vim" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\24CmpDictionaryUpdate\bcmd\bvim¶\2\1\0\5\0\v\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0029\1\t\0003\3\n\0B\1\2\1K\0\1\0\0\brun\18plenary.async\bdic\1\0\b\rcapacity\3\5\14max_items\3ÿÿÿÿ\15\nasync\2\21document_command\16wn %s -over\rdocument\2\27first_case_insensitive\1\nexact\3ÿÿÿÿ\15\ndebug\1\6*\1\0\0\1\3\0\0\25~/.config/nvim/words&~/.config/nvim/spell/en.utf-8.add\nsetup\19cmp_dictionary\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/opt/cmp-dictionary",
    url = "https://github.com/uga-rosa/cmp-dictionary"
  },
  ["fugitive-gitlab.vim"] = {
    config = { "\27LJ\2\ng\0\0\4\0\6\0\n6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0014\2\3\0009\3\5\0>\3\1\2=\2\4\1K\0\1\0\15GITALB_URL\28fugitive_gitlab_domains\6g\bvim\vsecret\frequire\0" },
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/fugitive-gitlab.vim",
    url = "https://github.com/shumphrey/fugitive-gitlab.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/Users/jingdizhu/.local/share/nvim/site/pack/packer/start/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: fugitive-gitlab.vim
time([[Config for fugitive-gitlab.vim]], true)
try_loadstring("\27LJ\2\ng\0\0\4\0\6\0\n6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0014\2\3\0009\3\5\0>\3\1\2=\2\4\1K\0\1\0\15GITALB_URL\28fugitive_gitlab_domains\6g\bvim\vsecret\frequire\0", "config", "fugitive-gitlab.vim")
time([[Config for fugitive-gitlab.vim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'cmp-dictionary'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
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

-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)

local g = vim.g
local opt = vim.opt-- autocmds
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = ","
g.neoformat_try_node_exe = 1

opt.swapfile = false
opt.spellfile = '~/.vim/spell/en.utf-8.add'

autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "<buffer>" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})

local tabs_config = function()
  -- print("Loading JS File tab preferences (tabs)")
  opt.shiftwidth = 2
  opt.tabstop = 2
  opt.expandtab = false
  opt.smartindent = true
  opt.autoindent = true
end

local spaces_config = function()
  -- print("Loading JS File tab preferences (spaces)")
  opt.shiftwidth = 2
  opt.tabstop = 2
  opt.expandtab = true
  opt.smartindent = true
  opt.autoindent = true
end

local load_tab_prefs = function()
  local buf_name = vim.api.nvim_buf_get_name(0)

  if string.find(buf_name, "/photivo/") then
    tabs_config()
  else
    spaces_config()
  end
end

autocmd("FileType", {
  pattern = "javascript,vue,javascriptreact",
  callback = load_tab_prefs,
})

-- autocmd("FileType", {
--   pattern = "*.js",
--   -- pattern = "/Users/rbrown/workspace/discover-ui/*.js",
--   callback = spaces_config,
-- })

autocmd("FileType", {
  pattern = "python",
  callback = function()
    opt.expandtab = true
    opt.shiftwidth = 2
    opt.smartindent = true
    opt.tabstop = 2
    opt.softtabstop = 2
  end,
})

-- autocmd("BufWritePre", {
--   pattern = "*.js",
--   callback = function()
--     vim.cmd "Neoformat"
--   end,
-- })

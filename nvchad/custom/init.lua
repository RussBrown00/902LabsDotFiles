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
    print("Loading JS File tab preferences")
    opt.expandtab = false
    opt.shiftwidth = 4
    opt.smartindent = true
    opt.tabstop = 4
    opt.softtabstop = 4
  end

local spaces_config = function()
    print("Loading JS File tab preferences")
    opt.expandtab = true
    opt.shiftwidth = 2
    opt.smartindent = true
    opt.tabstop = 2
    opt.softtabstop = 2
  end

autocmd("FileType", {
  pattern = "javascript,vue,javascriptreact",
  callback = spaces_config,
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

-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)

local g = vim.g
local opt = vim.opt-- autocmds
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = ","
g.neoformat_try_node_exe = 1

opt.noswapfile = true
opt.spellang = 'en'
opt.spellfile = '~/.vim/spell/en.utf-8.add'

-- Indenting
opt.expandtab = true
opt.shiftwidth = 3
opt.smartindent = true
opt.tabstop = 3
opt.softtabstop = 3

autocmd("BufWritePre", {
  pattern = "*.js",
  callback = function()
    vim.cmd "Neoformat"
  end,
})

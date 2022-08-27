-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)

local g = vim.g
local opt = vim.opt

g.mapleader = ","

opt.noswapfile = true
opt.spellang = 'en'
opt.spellfile = '~/.vim/spell/en.utf-8.add'

-- Indenting
opt.expandtab = true
opt.shiftwidth = 3
opt.smartindent = true
opt.tabstop = 3
opt.softtabstop = 3

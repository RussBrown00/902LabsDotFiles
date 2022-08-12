-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)
vim.g.mapleader = ","

local opt = vim.opt

opt.noswapfile = true
opt.spellang = 'en'
opt.spellfile = '~/.vim/spell/en.utf-8.add'

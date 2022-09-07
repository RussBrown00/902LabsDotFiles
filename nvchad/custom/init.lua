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

autocmd("BufWritePre", {
  pattern = "*.js",
  callback = function()
    vim.cmd "Neoformat prettier"
  end,
})

-- Indenting
autocmd("FileType", {
  pattern = "javascript,javascriptreact",
  callback = function()
    vim.opt.expandtab = false
    vim.opt.shiftwidth = 3
    vim.opt.smartindent = true
    vim.opt.tabstop = 3
    vim.opt.softtabstop = 3
  end,
})

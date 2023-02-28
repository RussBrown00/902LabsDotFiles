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

vim.cmd [[ autocmd Filetype javascript setlocal expandtab=false tabstop=3 shiftwidth=3 softtabstop=3 smartindent=true ]]
vim.cmd [[ autocmd Filetype javascriptreact setlocal expandtab=false tabstop=3 shiftwidth=3 softtabstop=3 smartindent=true ]]
vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]

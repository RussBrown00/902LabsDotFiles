require "nvchad.options"

local opt = vim.opt

local spaces_config = function()
  -- print("Loading JS File tab preferences (spaces)")
  opt.shiftwidth = 2
  opt.tabstop = 2
  opt.expandtab = true
  opt.smartindent = true
  opt.autoindent = true
end

local load_tab_prefs = function()
  opt.laststatus = 3
  spaces_config()
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  callback = load_tab_prefs,
})

